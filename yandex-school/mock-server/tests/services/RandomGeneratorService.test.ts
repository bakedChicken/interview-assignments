import { RandomGeneratorService } from '../../src/services/RandomGeneratorService'

describe('RandomGeneratorService', () => {
  it('should return random number between 0 and 10', () => {
    const math = jest.fn()
    const randomGeneratorService = new RandomGeneratorService()
    const lowerBound = 0
    const upperBound = 10

    const actual = randomGeneratorService.getRandomNumber(
      lowerBound,
      upperBound
    )
    expect(actual).toBeGreaterThanOrEqual(lowerBound)
    expect(actual).toBeLessThanOrEqual(upperBound)
  })

  it('should return random number between 1 and 20', () => {
    const randomGeneratorService = new RandomGeneratorService()
    const lowerBound = 1
    const upperBound = 20

    const actual = randomGeneratorService.getRandomNumber(
      lowerBound,
      upperBound
    )
    expect(actual).toBeGreaterThanOrEqual(lowerBound)
    expect(actual).toBeLessThanOrEqual(upperBound)
  })
})
