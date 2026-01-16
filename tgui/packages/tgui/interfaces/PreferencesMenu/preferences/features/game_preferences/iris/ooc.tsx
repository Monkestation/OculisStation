import { type Feature, FeatureShortTextInput } from '../../base';

export const oocpronouns: Feature<string> = {
  name: 'OOC pronouns',
  category: 'CHAT',
  description:
    'Pronouns to show in OOC when someone hovers over your username, Separated by forward slashes. Most common pronouns and neopronouns are accepted. Custom text can be inserted afterwards. Example: "she/it/fae - my note here!"',
  component: FeatureShortTextInput,
};
