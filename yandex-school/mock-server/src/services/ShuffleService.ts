import { Service } from 'typedi'

@Service()
export class ShuffleService {
  shuffle<T>(array: T[]): T[] {
    const oldArray = [...array]
    let newArray = new Array<T>()

    while (oldArray.length) {
      const i = Math.floor(Math.random() * oldArray.length)
      newArray = newArray.concat(oldArray.splice(i, 1))
    }

    return newArray
  }
}
