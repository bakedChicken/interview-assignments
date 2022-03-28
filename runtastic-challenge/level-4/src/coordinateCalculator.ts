import { Point, PointDict, Route } from "./types";

export function haversineIntermediateSineSquared(
  value1: number,
  value2: number
): number {
  return Math.pow(Math.sin((value2 - value1) / 2), 2);
}

/**
 * @returns {number} Distance in KM
 */
export function getDistanceBetweenPoints(
  point1: Point,
  point2: Point,
  sphereRadius = 6371
): number {
  const phi1 = (point1.latitude * Math.PI) / 180;
  const phi2 = (point2.latitude * Math.PI) / 180;
  const lambda1 = (point1.longitude * Math.PI) / 180;
  const lambda2 = (point2.longitude * Math.PI) / 180;

  const step1 = haversineIntermediateSineSquared(phi1, phi2);
  const step2 = haversineIntermediateSineSquared(lambda1, lambda2);
  const step3 = Math.sqrt(step1 + Math.cos(phi1) * Math.cos(phi2) * step2);

  return 2 * sphereRadius * Math.asin(step3);
}

export function buildRoutesFromPoint(
  points: PointDict,
  origin: Point,
  route = new Set<number>(),
  routes: Point[][] = []
): Point[][] {
  if (route.has(origin.id)) {
    return [];
  }

  route.add(origin.id);

  if (origin.connections.length === 0) {
    routes.push([...route].map((rId) => points[rId]));
  }

  for (const destId of origin.connections) {
    buildRoutesFromPoint(points, points[destId], new Set(route), routes);
  }

  return routes;
}

export function calculateRouteDistance(route: Point[]): Route {
  let totalDistanceForRoute = 0;

  for (let i = 0; i < route.length - 1; i++) {
    totalDistanceForRoute += getDistanceBetweenPoints(route[i], route[i + 1]);
  }

  return {
    routeId: route.map((p) => p.id).join(),
    points: route,
    distance: Math.round(totalDistanceForRoute * 1000),
  };
}
