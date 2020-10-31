import React from "react";
import ReactDOM from "react-dom";

type DelayButtonProps = {
  value: string;
  delay: number;
};

function DelayButton({ value, delay }: DelayButtonProps) {
  const dispatch = React.useContext(RootContext);

  function handleDelayButton() {
    dispatch?.({
      type: DelayReducerDispatchType.ADD_DELAY_TO_QUEUE,
      payload: {
        buttonPressedTime: new Date(),
        delay,
      },
    });
  }

  return <button onClick={handleDelayButton}>{value}</button>;
}

function ResetButton() {
  const dispatch = React.useContext(RootContext);

  function handleResetClick() {
    dispatch?.({ type: DelayReducerDispatchType.RESET_QUEUE });
  }

  return <button onClick={handleResetClick}>Сбросить</button>;
}

const RootContext = React.createContext<
  ((action: DelayReducerAction) => void) | null
>(null);

type DelayReducerState = {
  queue: unknown[];
};

enum DelayReducerDispatchType {
  ADD_DELAY_TO_QUEUE = "ADD_DELAY_TO_QUEUE",
  RESET_QUEUE = "RESET_QUEUE",
}

type DelayReducerAction =
  | {
      type: DelayReducerDispatchType.ADD_DELAY_TO_QUEUE;
      payload: {
        buttonPressedTime: Date;
        delay: number;
      };
    }
  | {
      type: DelayReducerDispatchType.RESET_QUEUE;
    };

function delayReducer(state: DelayReducerState, action: DelayReducerAction) {
  switch (action.type) {
    case DelayReducerDispatchType.ADD_DELAY_TO_QUEUE:
      return {
        ...state,
        queue: [...state.queue, action.payload.delay],
      };
    case DelayReducerDispatchType.RESET_QUEUE:
      return {
        ...state,
        queue: [],
      };
    default:
      return state;
  }
}

function Root() {
  const textAreaRef = React.createRef<HTMLTextAreaElement>();
  const [state, dispatch] = React.useReducer(delayReducer, { queue: [] });

  React.useEffect(() => {
    console.log(state);
  }, [state]);

  return (
    <RootContext.Provider value={dispatch}>
      <DelayButton value="Кнопка 1" delay={1000} />
      <DelayButton value="Кнопка 2" delay={2000} />
      <DelayButton value="Кнопка 3" delay={3000} />
      <ResetButton />
      <textarea ref={textAreaRef} />
    </RootContext.Provider>
  );
}

ReactDOM.render(<Root />, document.getElementById("root"));
