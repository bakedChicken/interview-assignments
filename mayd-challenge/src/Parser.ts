import { LogLevels, assertStringIsLogLevel } from "./LogLevels";
import { InputLogMessage } from "./types";

export type ParserSuccessResult<T> = {
  result: "ok";
  message: T;
};

export type ParserErrorResult = {
  result: "error";
  error: Error;
};

export type ParserResult<T> = ParserSuccessResult<T> | ParserErrorResult;

export interface Parser<T> {
  parse: (line: string) => ParserResult<T>;
}

export class MalformedLogMessageError extends Error {
  constructor(readonly raw: string) {
    super(`The log message has malformed format:\n${raw}`);
  }
}

export class LogMessageFormatParser implements Parser<InputLogMessage> {
  smartSplit(raw: string, separator: string, limit: number): string[] {
    let result: string[] = [];
    // 2021-08-09T02:12:51.259Z - error - {"transactionId":"9abc55b2-807b-4361-9dbe-aa88b1b2e978","details":"The request is failed socket hang up","code": 500,"err":"Network error - socket hang up"}
    // indexes: [ 20, 50 ]
    let lastIndexOf = raw.indexOf(separator);
    for (let i = 0; i < limit; i++) {
      result.push(lastIndexOf);
    }
    return result;
  }

  parse(line: string): ParserResult<InputLogMessage> {
    try {
      const splittedLine = this.smartSplit(line, " - ", 3);

      console.log(splittedLine);

      if (splittedLine.length !== 3) {
        return {
          result: "error",
          error: new MalformedLogMessageError(line),
        };
      }

      const [date, logLevel, message] = splittedLine;
      assertStringIsLogLevel(logLevel);

      return {
        result: "ok",
        message: {
          loggedAt: new Date(date),
          logLevel: logLevel as LogLevels,
          message: JSON.parse(message),
        },
      };
    } catch (error: unknown) {
      return {
        result: "error",
        error: error as Error,
      };
    }
  }
}
