# Plugin-dvax

umi 插件，dva 用法封装

## Install

`yarn add umi-plugin-dvax`

## Usage

启用插件，在.umirc.ts：

```ts
export default defineConfig({
  dva: {
    // 跳过model检测
    skipModelValidate: true,
  },
});
```

在 model 文件内:

```typescript
import { createModel } from "@@/plugin-dvax";

interface Param {
  a: number;
}

export default createModel<Param>({
  namespace: "test-model",
  state: {
    a: 1,
  },
  // 自定义reducer
  reducer: {
    add: (state, action) => {
      return {
        ...state,
        a: state.a + 1,
      };
    },
  },
});
```

在组件内使用：

```tsx
export default function Index() {
  // 响应式获取数据
  const { a } = useSelector(testModel.selector);

  // 非响应式获取数据
  const getState = () => {
    const { a } = testModel.getState();
    return a;
  };

  // 修改
  const update = () => {
    testModel.actions.update({ a: a + 1 });
  };

  // 重置
  const reset = () => {
    testModel.actions.reset();
  };

  // dispatch
  const add = () => {
    testModel.dispatch("add");
  };

  return <div>{a}</div>;
}
```
