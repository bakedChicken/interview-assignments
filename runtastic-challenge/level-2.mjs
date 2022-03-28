// Fetched at the previous step
const points = [
  {
    id: 1,
    latitude: 48.26537218,
    longitude: 14.20509304,
    connections: [18, 20, 33],
  },
  {
    id: 2,
    latitude: 48.24632053,
    longitude: 14.20455305,
    connections: [13, 28, 36],
  },
  {
    id: 3,
    latitude: 48.25146882,
    longitude: 14.19957141,
    connections: [49],
  },
  {
    id: 4,
    latitude: 48.26219374,
    longitude: 14.19541025,
    connections: [15, 24],
  },
  {
    id: 5,
    latitude: 48.2496577,
    longitude: 14.20988148,
    connections: [18, 32],
  },
  {
    id: 6,
    latitude: 48.24657505,
    longitude: 14.2041792,
    connections: [25, 49],
  },
  {
    id: 7,
    latitude: 48.26521216,
    longitude: 14.2001078,
    connections: [15, 25, 27],
  },
  {
    id: 8,
    latitude: 48.26358679,
    longitude: 14.20699823,
    connections: [],
  },
  {
    id: 9,
    latitude: 48.26511841,
    longitude: 14.20002616,
    connections: [27],
  },
  {
    id: 10,
    latitude: 48.25182578,
    longitude: 14.19316522,
    connections: [22, 29],
  },
  {
    id: 11,
    latitude: 48.24766749,
    longitude: 14.2045224,
    connections: [12, 43],
  },
  {
    id: 12,
    latitude: 48.26602343,
    longitude: 14.19883521,
    connections: [13, 42, 47],
  },
  {
    id: 13,
    latitude: 48.2674478,
    longitude: 14.21846075,
    connections: [47],
  },
  {
    id: 14,
    latitude: 48.2473654,
    longitude: 14.2142406,
    connections: [7, 23, 28, 44],
  },
  {
    id: 15,
    latitude: 48.26188362,
    longitude: 14.21778865,
    connections: [],
  },
  {
    id: 16,
    latitude: 48.24983579,
    longitude: 14.21116621,
    connections: [12, 39],
  },
  {
    id: 17,
    latitude: 48.26726006,
    longitude: 14.21837438,
    connections: [8, 33],
  },
  {
    id: 18,
    latitude: 48.2521456,
    longitude: 14.19231059,
    connections: [28, 34],
  },
  {
    id: 19,
    latitude: 48.26111871,
    longitude: 14.20799909,
    connections: [28],
  },
  {
    id: 20,
    latitude: 48.26054901,
    longitude: 14.19334873,
    connections: [14, 19],
  },
  {
    id: 21,
    latitude: 48.26260156,
    longitude: 14.19825839,
    connections: [3, 27],
  },
  {
    id: 22,
    latitude: 48.26544364,
    longitude: 14.21656785,
    connections: [27],
  },
  {
    id: 23,
    latitude: 48.25803662,
    longitude: 14.18751903,
    connections: [2],
  },
  {
    id: 24,
    latitude: 48.24991881,
    longitude: 14.19593243,
    connections: [26],
  },
  {
    id: 25,
    latitude: 48.25561491,
    longitude: 14.18709979,
    connections: [19, 29],
  },
  {
    id: 26,
    latitude: 48.2602201,
    longitude: 14.19130003,
    connections: [],
  },
  {
    id: 27,
    latitude: 48.26482357,
    longitude: 14.21993979,
    connections: [12],
  },
  {
    id: 28,
    latitude: 48.26154725,
    longitude: 14.18843109,
    connections: [27],
  },
  {
    id: 29,
    latitude: 48.26132937,
    longitude: 14.19468114,
    connections: [1, 5, 47],
  },
  {
    id: 30,
    latitude: 48.26049532,
    longitude: 14.20044226,
    connections: [3, 26],
  },
  {
    id: 31,
    latitude: 48.26190507,
    longitude: 14.21194045,
    connections: [12],
  },
  {
    id: 32,
    latitude: 48.25397396,
    longitude: 14.2126089,
    connections: [2, 24, 30],
  },
  {
    id: 33,
    latitude: 48.24862297,
    longitude: 14.19467929,
    connections: [32],
  },
  {
    id: 34,
    latitude: 48.25046808,
    longitude: 14.2121432,
    connections: [],
  },
  {
    id: 35,
    latitude: 48.2552707,
    longitude: 14.20796386,
    connections: [5],
  },
  {
    id: 36,
    latitude: 48.25590763,
    longitude: 14.19483122,
    connections: [17, 31],
  },
  {
    id: 37,
    latitude: 48.2578281,
    longitude: 14.21044182,
    connections: [22],
  },
  {
    id: 38,
    latitude: 48.2665753,
    longitude: 14.21608256,
    connections: [26],
  },
  {
    id: 39,
    latitude: 48.26992876,
    longitude: 14.20097901,
    connections: [1, 17, 48],
  },
  {
    id: 40,
    latitude: 48.26008475,
    longitude: 14.22314291,
    connections: [1],
  },
  {
    id: 41,
    latitude: 48.26710678,
    longitude: 14.21661412,
    connections: [20, 33],
  },
  {
    id: 42,
    latitude: 48.26669163,
    longitude: 14.21723491,
    connections: [],
  },
  {
    id: 43,
    latitude: 48.26332866,
    longitude: 14.21553014,
    connections: [1, 16, 38],
  },
  {
    id: 44,
    latitude: 48.25414499,
    longitude: 14.21369676,
    connections: [],
  },
  {
    id: 45,
    latitude: 48.26662042,
    longitude: 14.19013957,
    connections: [9, 12, 39],
  },
  {
    id: 46,
    latitude: 48.26865097,
    longitude: 14.21258413,
    connections: [],
  },
  {
    id: 47,
    latitude: 48.24955368,
    longitude: 14.20137209,
    connections: [15],
  },
  {
    id: 48,
    latitude: 48.25558981,
    longitude: 14.2232754,
    connections: [2, 18],
  },
  {
    id: 49,
    latitude: 48.2591433,
    longitude: 14.22473131,
    connections: [],
  },
  {
    id: 50,
    latitude: 48.24917878,
    longitude: 14.20613196,
    connections: [2, 5, 47],
  },
];

/**
 * @typedef Point
 * @type {object}
 * @property {number} id
 * @property {number} latitude
 * @property {number} longitude
 * @property {number[]} connections
 */

/**
 * @param {number} value1
 * @param {number} value2
 * @returns {number}
 */
function haversineIntermediateSineSquared(value1, value2) {
  return Math.pow(Math.sin((value2 - value1) / 2), 2);
}

/**
 * @param {Point} point1
 * @param {Point} point2
 * @param {number} sphereRadius
 * @returns {number} Distance in KM
 */
function getDistanceBetweenPoints(point1, point2, sphereRadius = 6371) {
  const phi1 = (point1.latitude * Math.PI) / 180;
  const phi2 = (point2.latitude * Math.PI) / 180;
  const lambda1 = (point1.longitude * Math.PI) / 180;
  const lambda2 = (point2.longitude * Math.PI) / 180;

  const step1 = haversineIntermediateSineSquared(phi1, phi2);
  const step2 = haversineIntermediateSineSquared(lambda1, lambda2);
  const step3 = Math.sqrt(step1 + Math.cos(phi1) * Math.cos(phi2) * step2);

  return 2 * sphereRadius * Math.asin(step3);
}

/**
 * @param {number} pointId
 * @returns {Point}
 */
function findPointById(pointId) {
  const point = points.find((p) => p.id === pointId);

  if (!point) {
    throw new Error(`Couldn't find the point with id ${pointId}`);
  }

  return point;
}

/**
 * @param {number} pointId
 * @returns {number[]}
 */
function getDistancesForPoint(pointId) {
  const origin = findPointById(pointId);

  return origin.connections.map((pId) =>
    Math.round(getDistanceBetweenPoints(origin, findPointById(pId)) * 1000)
  );
}

console.log(getDistancesForPoint(14).reduce((a, b) => a + b, 0));
