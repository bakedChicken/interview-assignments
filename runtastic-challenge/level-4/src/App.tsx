import React from "react";
import {
  AppBar,
  CssBaseline,
  makeStyles,
  MenuItem,
  Toolbar,
  Typography,
  TextField,
  type TextFieldProps,
  CircularProgress,
} from "@material-ui/core";

import { type Point, type PointInitial, SortDirection } from "./types";
import { RouteList } from "./RouteList";
import { ErrorViewer } from "./ErrorViewer";
import { fetchAllPoints } from "./fetchAllPoints";

export function usePointsLoader(): [PointInitial, boolean, Error | null] {
  const [points, setPoints] = React.useState<PointInitial>({
    points: [],
    availablePointsForOrigin: [],
    defaultOriginId: 1,
  });
  const [isLoading, setIsLoading] = React.useState(true);
  const [error, setError] = React.useState<Error | null>(null);

  React.useEffect(() => {
    const abortController = new AbortController();

    fetchAllPoints("/coordinates", abortController)
      .then((points: Point[]) => {
        const availablePointsForOrigin = points.filter(
          (p) => p.connections.length > 0
        );
        const originPointId = availablePointsForOrigin?.[0]?.id ?? null;

        return {
          points,
          availablePointsForOrigin,
          defaultOriginId: originPointId,
        };
      })
      .then(setPoints)
      .catch(setError)
      .finally(() => setIsLoading(false));

    return () => abortController.abort();
  }, []);

  return [points, isLoading, error];
}

const useStyles = makeStyles((theme) => ({
  title: {
    flexGrow: 1,
  },
  select: {
    borderRadius: theme.shape.borderRadius,
    width: "24ch",
  },
  originPointInput: {
    marginRight: theme.spacing(4),
  },
  content: {
    height: `calc(100vh - ${theme.mixins.toolbar.minHeight}px)`,
    width: "100vw",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
  },
}));

export function App() {
  const classes = useStyles();
  const [points, isLoading, error] = usePointsLoader();
  const [originPointId, setOriginPointId] = React.useState<number>(
    points?.defaultOriginId ?? -1
  );
  const [sortDirection, setSortDirection] = React.useState<SortDirection>(
    SortDirection.ASCENDING
  );

  const handleSortDirectionChange: TextFieldProps["onChange"] = (event) => {
    setSortDirection(event.target.value as SortDirection);
  };

  const handleOriginPointChange: TextFieldProps["onChange"] = (event) => {
    setOriginPointId(+event.target.value);
  };

  return (
    <>
      <CssBaseline />
      <AppBar position="static" color="transparent">
        <Toolbar>
          <Typography className={classes.title} variant="h5">
            Route List
          </Typography>

          <TextField
            className={`${classes.select} ${classes.originPointInput}`}
            id="origin-point-input"
            label="Choose origin point"
            value={originPointId}
            onChange={handleOriginPointChange}
            select
            disabled={isLoading}
          >
            {points.availablePointsForOrigin.map((p) => (
              <MenuItem
                key={p.id}
                value={p.id}
              >{`${p.id} (${p.latitude}, ${p.longitude})`}</MenuItem>
            ))}
          </TextField>

          <TextField
            className={classes.select}
            id="sort-by-route-length-input"
            label="Sort by route length"
            value={sortDirection}
            onChange={handleSortDirectionChange}
            select
          >
            <MenuItem value={SortDirection.ASCENDING}>ascending</MenuItem>
            <MenuItem value={SortDirection.DESCENDING}>descending</MenuItem>
          </TextField>
        </Toolbar>
      </AppBar>

      {(isLoading || error) && (
        <div className={classes.content}>
          {isLoading && <CircularProgress />}
          {error && <ErrorViewer error={error} />}
        </div>
      )}

      {!isLoading && !error && (
        <main>
          <RouteList
            points={points.points}
            originPointId={originPointId}
            sortDirection={sortDirection}
          />
        </main>
      )}
    </>
  );
}
