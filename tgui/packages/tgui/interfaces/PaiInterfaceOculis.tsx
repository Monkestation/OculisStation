import { useState } from 'react';
import {
  Box,
  Button,
  Flex,
  LabeledList,
  ProgressBar,
  Section,
  Tabs,
} from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

export const PaiInterfaceOculis = (Props, context) => {
  const { data } = useBackend(context);
  const [tab, setTab] = useState('general');
  return (
    <Window width={580} height={700}>
      <Window.Content scrollable>
        <Flex>
          <Flex.Item grow>
            <Section>
              <Tabs fluid>
                <Tabs.Tab
                  onClick={() => setTab('general')}
                  selected={tab === 'general'}
                  backgroundColor={tab === 'general' ? 'green' : 'default'}
                >
                  General
                </Tabs.Tab>
                <Tabs.Tab
                  onClick={() => setTab('settings')}
                  selected={tab === 'settings'}
                  backgroundColor={tab === 'settings' ? 'yellow' : 'default'}
                >
                  Settings
                </Tabs.Tab>
              </Tabs>
            </Section>

            {tab === 'general' ? (
              <PaiInterfaceOculisGeneral />
            ) : (
              <PaiInterfaceOculisSettings />
            )}
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};

const PaiInterfaceOculisGeneral = (props) => {
  const { act, data } = useBackend();
  const { name, health, maxHealth } = data;
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
        <LabeledList.Item label="APPLICATIONS:">
          <Button
            content={'Open Persocom'}
            onClick={() => act('openpda')}
            color="good"
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const PaiInterfaceOculisSettings = (props) => {
  const { act } = useBackend();
  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="SCREEN OPTIONS">
          <Button content={'On'} onClick={() => act('screenon')} />
          <Button content={'What'} onClick={() => act('screenwhat')} />
          <Button content={'Sad'} onClick={() => act('screensad')} />
          <Button content={'Laugh'} onClick={() => act('screenlaugh')} />
          <Button content={'Happy'} onClick={() => act('screenhappy')} />
          <Button
            content={'Extremely Happy'}
            onClick={() => act('screenehappy')}
          />
          <Button content={'Cat'} onClick={() => act('screencat')} />
          <Button content={'Angry'} onClick={() => act('screenangry')} />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
