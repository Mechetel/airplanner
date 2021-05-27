import { Project } from "../../packs/schemas"
import { isProjectExist } from "../../packs/helpers"

describe("helpers", () => {
  it("isProjectExist", () => {
    let output = isProjectExist(new Project({ id: 1 }))
    expect(output).toEqual(true)

    output = isProjectExist({ id: "1" })
    expect(output).toEqual(true)

    output = isProjectExist(new Project({ id: "new" }))
    expect(output).toEqual(false)

    output = isProjectExist({ id: null })
    expect(output).toEqual(false)
  })
})
