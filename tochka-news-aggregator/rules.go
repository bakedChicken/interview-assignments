package main

import (
	"database/sql"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

type RulesController struct {
	Database *sql.DB

	HandleHttpGetRequest gin.HandlerFunc
	HandleHttpDeleteRequest gin.HandlerFunc
}

type RuleApiInput struct {
	Url string `json:"url" binding:"required"`
	HeaderSelector string `json:"headerSelector" binding:"required"`
	ContentSelector string `json:"contentSelector" binding:"required"`
}

type RuleApiOutput struct {
	Id string `json:"id"`
	Url string `json:"url"`
	HeaderSelector string `json:"headerSelector"`
	ContentSelector string `json:"contentSelector"`
}


func HandleHttpGetRequest(database *sql.DB) gin.HandlerFunc {
	return func(context *gin.Context) {
		rules, serviceErr := GetRules(database)

		if serviceErr != nil {
			context.JSON(http.StatusInternalServerError, gin.H{"error": serviceErr.Error()})
			return
		}

		context.JSON(http.StatusOK, rules)
	}
}

func GetRules(database *sql.DB) ([]*RuleApiOutput, error) {
	rows, err := database.Query(``)

	if err != nil {
		log.Fatalf("Error while handling GET /rules: %s", err)
	}

	defer rows.Close()

	return nil, err
}


func HandleHttpDeleteRequest(database *sql.DB) gin.HandlerFunc {
	return func(context *gin.Context) {

	}
}

func DeleteRule(database *sql.DB, ruleId string) error {
	row, err := database.QueryRow(`SELECT id FROM rules WHERE rule_id = ?`, ruleId)

	if err != nil {
		panic(err)
	}

	scanErr := row.Scan()

	database.Exec(`DELETE FROM rules WHERE rule_id = ?`, ruleId)
}


func NewRulesController(database *sql.DB) *RulesController {
	return &RulesController{
		Database: database,
		HandleHttpGetRequest: HandleHttpGetRequest(database),
		HandleHttpDeleteRequest: HandleHttpDeleteRequest(database),
	}
}
