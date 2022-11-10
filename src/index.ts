import { IApi } from "umi";
import { join } from "path";
import { readFileSync } from "fs";
import { Mustache } from "@umijs/utils";
import umiInfo from "umi/package.json";

export default (api: IApi) => {
  const namespace = umiInfo.version.startsWith("4") ? "" : "plugin-dvax";
  const createModelTpl = readFileSync(
    join(__dirname, "../tpl/createModel.tpl"),
    "utf-8"
  );
  const indexTpl = readFileSync(join(__dirname, "../tpl/index.tpl"), "utf-8");

  api.onGenerateFiles(() => {
    try {
      api.writeTmpFile({
        path: `${namespace}/createModel.ts`,
        content: Mustache.render(createModelTpl, {}),
      });
    } catch (e) {
      api.logger.error(e);
    }
  });

  api.onGenerateFiles(() => {
    try {
      api.writeTmpFile({
        path: `${namespace}/index.ts`,
        content: Mustache.render(indexTpl, {}),
      });
    } catch (e) {
      api.logger.error(e);
    }
  });
};
