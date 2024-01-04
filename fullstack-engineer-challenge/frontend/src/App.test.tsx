import { renderHook } from "@testing-library/react-hooks";
import { useLocationToPageTitleMapper } from "./App";

describe("useLocationToPageTitleMapper hook", () => {
  it("should return empty string for unregistered location", () => {
    const useLocation = jest.fn();
    const useParams = jest.fn();

    useLocation.mockReturnValueOnce({
      pathname: "",
    });
    useParams.mockReturnValueOnce({
      id: "",
    });

    const { result } = renderHook(() => useLocationToPageTitleMapper());

    expect(result).toBe("");
  });
});
