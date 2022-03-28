import React from "react";
import { Typography } from "@material-ui/core";
import { ChevronLeft, ChevronRight } from "@material-ui/icons";

export type ErrorViewerProps = {
  error: Error;
};

export function ErrorViewer({ error }: ErrorViewerProps) {
  const [isCauseVisible, setIsCauseVisible] = React.useState(false);

  const handleClick = () => {
    setIsCauseVisible((prevValue) => !prevValue);
  };

  return (
    <div>
      <Typography variant="h5" color="error">
        {error.message}
      </Typography>

      {error.cause && (
        <div onClick={handleClick}>
          {isCauseVisible && <ChevronLeft />}
          {!isCauseVisible && <ChevronRight />}

          <Typography>Click here to find more.</Typography>

          {isCauseVisible && <pre>{error.cause?.message}</pre>}
        </div>
      )}
    </div>
  );
}
