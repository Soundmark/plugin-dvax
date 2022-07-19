import { getDvaApp } from "umi";
import type {
  EffectsMapObject,
  ReducersMapObjectWithEnhancer,
  SubscriptionsMapObject,
} from "dva";
import type { AnyAction, ReducersMapObject } from "redux";
import type { DefaultRootState } from "react-redux";

export interface IModel<T> {
  namespace: string;
  state?: T;
  reducers?: ReducersMapObject | ReducersMapObjectWithEnhancer;
  effects?: EffectsMapObject;
  subscriptions?: SubscriptionsMapObject;
}

export interface Model<T> {
  namespace: string;
  selector: (state?: DefaultRootState) => T;
  getState: () => T;
  dispatch: (action: AnyAction) => void;
  actions: {
    set: (payload: Partial<T>) => void;
    reset: () => void;
    update: (payload: Partial<T>) => void;
  };
}

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
