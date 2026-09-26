import { config, DotenvResult } from 'dotenv'
import { join, resolve } from 'path'
import { Service } from 'typedi'

const dotenvPath = join(__dirname, '..', '..', '.env')
const dotenvConfig = config({ path: dotenvPath })

type DotenvKey = 'HOST' | 'PORT' | 'STORAGE_PATH' | 'MAX_IMAGE_COUNT'
type MyDotenvConfig = { [name in DotenvKey]: string }

@Service()
export class EnvironmentService {
  constructor(private config: MyDotenvConfig) {
    this.config = dotenvConfig.parsed as MyDotenvConfig
  }

  getHost(): string {
    return this.config.HOST
  }

  getPort(): string {
    return this.config.PORT
  }

  getServerUrl(): string {
    return `${this.getHost()}:${this.getPort()}`
  }

  getStoragePath(): string {
    return resolve(this.config.STORAGE_PATH)
  }

  getMaxImageCount(): number {
    return parseInt(this.config.MAX_IMAGE_COUNT)
  }
}
