import { Get, JsonController, QueryParam } from 'routing-controllers'

import { EnvironmentService } from '../services/EnvironmentService'
import { FileService } from '../services/FileService'
import { RandomGeneratorService } from '../services/RandomGeneratorService'

@JsonController()
export class YobaController {
  constructor(
    private fileService: FileService,
    private envService: EnvironmentService,
    private randomGeneratorService: RandomGeneratorService
  ) {}

  @Get('/images')
  getAllImages(@QueryParam('count') count: number) {
    const imageCount =
      count ||
      this.randomGeneratorService.getRandomNumber(
        0,
        this.envService.getMaxImageCount()
      )

    return this.fileService.getImagesInStorage(imageCount)
  }
}
