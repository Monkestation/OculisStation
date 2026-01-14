import { type Feature, FeatureShortTextInput } from '../../base';

export const oocpronouns: Feature<string> = {
  name: 'OOC pronouns',
  category: 'CHAT',
  description:
    'Pronouns to show in OOC when someone hovers over your username, Separated by forward slashes. Most common pronouns and neopronouns are accepted with a max of 4 (Staff are exempt from limits but please use it in good faith). Example: "she/it/fae"',
  component: FeatureShortTextInput,
};
