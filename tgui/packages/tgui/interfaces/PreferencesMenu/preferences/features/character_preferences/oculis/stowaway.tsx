// THIS IS AN OCULIS STATION UI FILE
import { type Feature, FeatureShortTextInput } from '../../base';

export const stowaway_alias: Feature<string> = {
  name: 'Fake ID Alias',
  description:
    'Optional alias printed on your counterfeit ID. Leave blank to use your real name.',
  component: FeatureShortTextInput,
};
