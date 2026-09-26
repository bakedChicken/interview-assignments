import { readdir } from 'fs'
import { Service } from 'typedi'
import { promisify } from 'util'

@Service()
export class PromisifyService {
  constructor(private readdirPromise = promisify(readdir)) {}

  async readDir(path: string): Promise<Array<string>> {
    return this.readdirPromise(path)
  }
}
