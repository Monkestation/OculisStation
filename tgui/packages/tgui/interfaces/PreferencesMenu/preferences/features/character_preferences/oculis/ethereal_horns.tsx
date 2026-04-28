import {
  CheckboxInput,
  Feature,
  FeatureChoicedServerData,
  FeatureToggle,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const ethereal_horns_toggle: FeatureToggle = {
  name: 'Ethereal Horns',
  component: CheckboxInput,
};

export const feature_ethereal_horns: Feature<string> = {
  name: 'Ethereal Horns Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};
