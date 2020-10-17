package main

import (
	"context"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"go.uber.org/fx"
)

func NewGinRouter(rulesController *RulesController) *gin.Engine {
	r := gin.Default()

	api := r.Group("/api/v1")
	api.GET("/rules", rulesController.HandleHttpGetRequest)
	api.DELETE("/rule/:ruleId", rulesController.HandleHttpDeleteRequest)

	return r
}

func NewMux(lc fx.Lifecycle, engine *gin.Engine) {
	server := &http.Server{
		Addr:    ":3000",
		Handler: engine,
	}

	lc.Append(fx.Hook{
		OnStart: func(ctx context.Context) error {
			go func() {
				if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
					log.Fatalf("Error while initializing server: %s\n", err)
				}
			}()
			return nil
		},
		OnStop: func(ctx context.Context) error {
			return server.Shutdown(ctx)
		},
	})
}

func main() {
	app := fx.New(
		fx.Provide(
			NewGinRouter,
			NewRulesController,
		),
		fx.Invoke(NewMux),
	)
	app.Run()
}
