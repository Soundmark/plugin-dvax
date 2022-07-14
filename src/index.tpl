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

export * from './createModel'