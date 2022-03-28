import type { Point } from "./types";

export async function fetchAllPoints(
  url: string,
  abortController: AbortController,
  coordinates: Point[] = []
): Promise<Point[]> {
  if (!url) {
    return coordinates;
  }

  const response = await fetch(url, {
    signal: abortController.signal,
  });

  if (!response.ok) {
    throw new Error("Something went wrong!", {
      cause: new Error(
        `Request for '${url}' failed with error: ${await response.text()}`
      ),
    });
  }

  const json = await response.json();
  coordinates.push(...json.coordinates);

  return fetchAllPoints(json.links.next, abortController, coordinates);
}
