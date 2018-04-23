import { ShuffleService } from '../../src/services/ShuffleService'

describe('ShuffleService', () => {
  it('should shuffle array', () => {
    const shuffleService = new ShuffleService()
    const size = 100
    const sequentialArray = Array.from(new Array(size), (val, index) => index)
    const actual = shuffleService.shuffle(sequentialArray)
    expect(actual).toHaveLength(size)
    sequentialArray.forEach(value => {
      expect(actual).toContain(value)
    })
  })
})
