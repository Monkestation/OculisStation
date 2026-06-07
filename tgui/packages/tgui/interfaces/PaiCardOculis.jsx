import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const PaiCardOculis = (Props, context) => {
  const { data } = useBackend(context);
  return (
    <Window width={400} height={200}>
      <Window.Content scrollable>
        <PaiCardOculisContent />
      </Window.Content>
    </Window>
  );
};

const PaiCardOculisContent = (props) => {
  const { act, data } = useBackend();
  const { health, maxHealth, name } = data;
  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="DESIGNATION">
          <Box color="good">{name}</Box>
        </LabeledList.Item>
        <LabeledList.Item label="SYSTEM INTEGRITY">
          <ProgressBar
            value={health / maxHealth}
            ranges={{
              good: [0.7, Infinity],
              average: [0.3, 0.7],
              bad: [-Infinity, 0.3],
            }}
          />
        </LabeledList.Item>
        <LabeledList.Item label="SYSTEM MANAGEMENT">
          <Button
            content={'Force Chassis Mode'}
            onClick={() => act('unfold')}
            color="bad"
          />
          <Button
            content={'Clear Access'}
            onClick={() => act('clearaccess')}
            color="bad"
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
