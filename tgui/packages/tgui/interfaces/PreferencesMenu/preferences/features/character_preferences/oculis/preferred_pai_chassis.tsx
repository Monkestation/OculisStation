import type { FeatureChoiced } from '../../base';

import { FeatureDropdownInput } from '../../dropdowns';

export const preferred_pai_chassis: FeatureChoiced = {
  name: 'pAI chassis',
  description:
    'The form you will initially take when spawning in as a pAI device.',
  component: FeatureDropdownInput,
};
