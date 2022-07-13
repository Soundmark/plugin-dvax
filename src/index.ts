import { IApi } from "umi";
import { join } from "path";
import { readFileSync } from "fs";

export default (api: IApi) => {
  const namespace = "plugin-dvax";
  const createModelTpl = readFileSync(
    join(__dirname, "createModel.tpl"),
    "utf-8"
  );
  const typeTpl = readFileSync(join(__dirname, "type.tpl"), "utf-8");

  api.onGenerateFiles(() => {
    try {
      api.writeTmpFile({
        path: `${namespace}/createModel.ts`,
        content: api.utils.Mustache.render(createModelTpl),
      });
    } catch (e) {
      api.logger.error(e);
    }
  });

  api.onGenerateFiles(() => {
    try {
      api.writeTmpFile({
        path: `${namespace}/type.ts`,
        content: api.utils.Mustache.render(typeTpl),
      });
    } catch (e) {
      api.logger.error(e);
    }
  });
};
