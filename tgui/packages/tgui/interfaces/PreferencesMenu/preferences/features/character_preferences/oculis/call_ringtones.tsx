import { sortBy } from 'es-toolkit/compat';
import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';
import type {
  Feature,
  FeatureChoicedServerData,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

const FeatureRingtoneDropdownInput = (
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
  };

  const handleForward = () => {
    props.handleSetValue(choices[nextIndex]);
  };

  return (
    <Stack>
      <Stack.Item>
        <Button
          onClick={() => act('play_call_ringtone_sound')}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => act('stop_call_ringtone_sound')}
          icon="stop"
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

export const call_ringtone: Feature<string> = {
  name: 'Call Ringtone Sound (Modlinks)',
  // component: FeatureDropdownInput,
  component: FeatureRingtoneDropdownInput,
};
