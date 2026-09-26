import { Inject, Service } from 'typedi'

import { EnvironmentService } from './EnvironmentService'
import { PromisifyService } from './PromisifyService'
import { ShuffleService } from './ShuffleService'

interface Image {
  id: number
  name: string
  url: string
}

@Service()
export class FileService {
  constructor(
    private envService: EnvironmentService,
    private shuffleService: ShuffleService,
    private promisifyService: PromisifyService
  ) {}

  async getImagesInStorage(count: number): Promise<Array<Image>> {
    const storagePath = this.envService.getStoragePath()
    const serverUrl = this.envService.getServerUrl()

    const files = await this.promisifyService.readDir(storagePath)
    const randomFiles = this.shuffleService.shuffle(files)

    return randomFiles
      .slice(0, count)
      .map(fileName => {
        const id = parseInt(fileName.replace(/^\D+/g, ''))
        const name = fileName
        const url = `http://${serverUrl}/storage/${fileName}`
        return { id, name, url }
      })
      .sort((fi, si) => fi.id - si.id)
  }
}
