import { sortBy } from 'es-toolkit/compat';
import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';
import {
  type Feature,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  FeatureShortTextInput,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const pda_theme: FeatureChoiced = {
  name: 'PDA Theme',
  category: 'GAMEPLAY',
  component: FeatureDropdownInput,
};

export const pda_ringtone: Feature<string> = {
  name: 'PDA Ringtone',
  component: FeatureShortTextInput,
};

const FeaturePdaDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) => {
  const { act } = useBackend();

  const serverData = props.serverData;
  if (!serverData) {
    return null;
  }

  const choices = sortBy<string>(serverData.choices);
  const currentIndex = choices.indexOf(props.value ?? '');
  const prevIndex = currentIndex > 0 ? currentIndex - 1 : choices.length - 1;
  const nextIndex =
    currentIndex < choices.length - 1 && currentIndex !== -1
      ? currentIndex + 1
      : 0;

  const handleBackward = () => {
    props.handleSetValue(choices[prevIndex]);
    act('play_ringtone_sound');
  };

  const handleForward = () => {
    props.handleSetValue(choices[nextIndex]);
    act('play_ringtone_sound');
  };

  return (
    <Stack>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_ringtone_sound');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={handleBackward}
          icon="step-backward"
          width="100%"
          height="100%"
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={handleForward}
          icon="step-forward"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const pda_ringtone_sound: Feature<string> = {
  name: 'PDA Ringtone Sound',
  // component: FeatureDropdownInput,
  component: FeaturePdaDropdownInput,
};
