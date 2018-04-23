import { Service } from 'typedi'

@Service()
export class RandomGeneratorService {
  getRandomNumber(start: number, end: number): number {
    return Math.floor(Math.random() * end) + start
  }
}
