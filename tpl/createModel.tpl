import { IModel, Model } from "./type";
import { getDvaApp } from "umi";

export const createModel = <T = any>({
  namespace,
  state,
  reducers = {},
  ...rest
}: IModel<T>): Model<T> => {
  return {
    namespace,
    state,
    getState() {
      return getDvaApp()._store.getState()[namespace];
    },
    dispatch(action) {
      return getDvaApp()._store.dispatch({
        ...action,
        type: `${namespace}/${action.type}`,
      });
    },
    reducers: {
      update(state, action) {
        return {
          ...state,
          ...action.payload,
        };
      },
      reset() {
        return state;
      },
      ...reducers,
    },
    selector(state) {
      return state[namespace];
    },
    actions: {
      update(payload) {
        getDvaApp()._store.dispatch({ type: `${namespace}/update`, payload });
      },
      reset() {
        getDvaApp()._store.dispatch({ type: `${namespace}/reset` });
      },
      set(payload) {
        getDvaApp()._store.dispatch({ type: `${namespace}/update`, payload });
      },
    },
    ...rest,
  } as Model<T>;
};
