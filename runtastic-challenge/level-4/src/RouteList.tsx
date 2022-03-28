import { List } from "@material-ui/core";

import { RouteListRow } from "./RouteListRow";
import {
  buildRoutesFromPoint,
  calculateRouteDistance,
} from "./coordinateCalculator";
import {
  type Point,
  type PointDict,
  type RouteWithRank,
  SortDirection,
} from "./types";

export type PointListProps = {
  points: Point[];
  originPointId: number;
  sortDirection: SortDirection;
};

export function useRouteCalculator(
  points: Point[],
  originPointId: number,
  sortByRouteDistance: SortDirection
): RouteWithRank[] {
  const pointsDict = points.reduce<PointDict>(
    (acc, point) => ({
      ...acc,
      [point.id]: point,
    }),
    {}
  );

  const routes = buildRoutesFromPoint(pointsDict, pointsDict[originPointId])
    .map(calculateRouteDistance)
    .map((r, index) => ({ ...r, rank: index + 1 }))
    .sort((r1, r2) =>
      sortByRouteDistance === SortDirection.ASCENDING
        ? r1.distance - r2.distance
        : r2.distance - r1.distance
    );

  return routes;
}

export function RouteList({
  points,
  originPointId,
  sortDirection,
}: PointListProps) {
  const routes = useRouteCalculator(points, originPointId, sortDirection);

  return (
    <List>
      {routes.map((r) => (
        <RouteListRow key={r.routeId} route={r} index={r.rank} />
      ))}
    </List>
  );
}
