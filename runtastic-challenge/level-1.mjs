// Must use Node 17.5 with --experimental-fetch flag

const initialUrl = "https://meet-and-code-2018.herokuapp.com/coordinates";

async function fetchAllCoordinates(url, coordinates = []) {
  if (!url) {
    return coordinates;
  }

  const response = await fetch(url);

  if (!response.ok) {
    throw new Error(
      `Request for '${url}' failed with error: ${await response.text()}`
    );
  }

  const json = await response.json();
  coordinates.push(...json.coordinates);

  return fetchAllCoordinates(json.links.next, coordinates);
}

const coordinates = await fetchAllCoordinates(initialUrl);
console.log(coordinates.length);
