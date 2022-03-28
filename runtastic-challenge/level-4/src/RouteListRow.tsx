import {
  ListItem,
  ListItemAvatar,
  Avatar,
  ListItemText,
  Typography,
  ListItemSecondaryAction,
} from "@material-ui/core";

import { Route } from "./types";

export type PointListRowProps = {
  route: Route;
  index: number;
};

export function RouteListRow({ route, index }: PointListRowProps) {
  return (
    <ListItem button>
      <ListItemAvatar>
        <Avatar src={`/routes/avatars?rank=${index}`} />
      </ListItemAvatar>

      <ListItemText
        primary={`Running route ${route.routeId}`}
        secondary={`${route.points.length} coordanates`}
      />

      <ListItemSecondaryAction>
        <Typography>{route.distance} m</Typography>
      </ListItemSecondaryAction>
    </ListItem>
  );
}
