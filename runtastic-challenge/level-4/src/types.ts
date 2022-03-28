export enum SortDirection {
  ASCENDING = "ASCENDING",
  DESCENDING = "DESCENDING",
}

export type Point = {
  id: number;
  latitude: number;
  longitude: number;
  connections: number[];
};

export type PointInitial = {
  points: Point[];
  availablePointsForOrigin: Point[];
  defaultOriginId: number | null;
};

export type PointDict = {
  [key: number]: Point;
};

export type Route = {
  routeId: string;
  points: Point[];
  distance: number;
};

export type RouteWithRank = Route & {
  rank: number;
};
