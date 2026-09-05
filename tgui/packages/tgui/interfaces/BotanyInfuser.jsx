import { toFixed } from 'tgui-core/math';
import { useBackend, useSharedState } from '../backend';
import {
  Box,
  Button,
  Flex,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Table,
  Tabs,
} from 'tgui-core/components';
import { Window } from '../layouts';

export const TimeFormat = (props) => {
  const { value } = props;

  const seconds = toFixed(Math.floor((value / 10) % 60)).padStart(2, '0');
  const minutes = toFixed(Math.floor((value / (10 * 60)) % 60)).padStart(
    2,
    '0',
  );
  const hours = toFixed(Math.floor((value / (10 * 60 * 60)) % 24)).padStart(
    2,
    '0',
  );
  const formattedValue = `${hours}:${minutes}:${seconds}`;
  return formattedValue;
};

export const InsertedSeed = (props) => {
  const { act, data } = useBackend();
  const { seed, has_seed, working } = data;
  if (!has_seed) {
    return !working && <NoticeBox info>Please insert a seed.</NoticeBox>;
  }
  return (
    <Section
      title="Seed"
      buttons={
        <Button
          icon="eject"
          disabled={!!working}
          onClick={() => act('eject_seed')}
          content="Eject Seed"
        />
      }
    >
      {!has_seed.length && 'No Seed detected.'}
      {!!has_seed.length && (
        <Table>
          {seed.map((node) => (
            <Table.Row key={node.ref}>
              <Table.Cell collapsing>
                <img
                  src={`data:image/jpeg;base64,${node.image}`}
                  style={{
                    verticalAlign: 'middle',
                    horizontalAlign: 'middle',
                  }}
                />
              </Table.Cell>
              <Table.Cell>{node.name}</Table.Cell>
              <LabeledList>
                <LabeledList.Item label="Potency">
                  <Box>{node.potency}</Box>
                </LabeledList.Item>
                <LabeledList.Item label="Yield">
                  <Box>{node.yield}</Box>
                </LabeledList.Item>
                <LabeledList.Item label="Production Speed">
                  <Box>{node.production_speed}</Box>
                </LabeledList.Item>
                <LabeledList.Item label="Maturation Speed">
                  <Box>{node.maturation_speed}</Box>
                </LabeledList.Item>
                <LabeledList.Item label="Endurance">
                  <Box>{node.endurance}</Box>
                </LabeledList.Item>
                <LabeledList.Item label="Lifespan">
                  <Box>{node.lifespan}</Box>
                </LabeledList.Item>
                <LabeledList.Item label="Weed Rate">
                  <Box>{node.weed_rate}</Box>
                </LabeledList.Item>
                <LabeledList.Item label="Weed Chance">
                  <Box>{node.weed_chance}</Box>
                </LabeledList.Item>
              </LabeledList>
              <Table.Cell />
            </Table.Row>
          ))}
        </Table>
      )}
    </Section>
  );
};

export const InsertedSeedInfusion = (props) => {
  const { act, data } = useBackend();
  const { seed, working } = data;
  if (!seed) {
    return !working && <NoticeBox info>Please insert a seed.</NoticeBox>;
  }
  return (
    <Section
      title="Seed"
      buttons={
        <Button
          icon="eject"
          disabled={!!working}
          onClick={() => act('eject_seed')}
          content="Eject Seed"
        />
      }
    >
      {!seed.length && 'No Seed detected.'}
      {!!seed.length && (
        <Table>
          {seed.map((node) => (
            <Table.Row key={node.ref}>
              <Table.Cell collapsing>
                <img
                  src={`data:image/jpeg;base64,${node.image}`}
                  style={{
                    verticalAlign: 'middle',
                    horizontalAlign: 'middle',
                  }}
                />
              </Table.Cell>
              <Table.Cell>{node.name}</Table.Cell>
              <LabeledList>
                <LabeledList.Item label="Potency">
                  <Box>
                    {node.potency} | {node.potency_change}
                  </Box>
                </LabeledList.Item>
                <LabeledList.Item label="Yield">
                  <Box>
                    {node.yield} | {node.yield_change}
                  </Box>
                </LabeledList.Item>
                <LabeledList.Item label="Production Speed">
                  <Box>
                    {node.production_speed} | {node.production_change}
                  </Box>
                </LabeledList.Item>
                <LabeledList.Item label="Maturation Speed">
                  <Box>
                    {node.maturation_speed} | {node.maturation_change}
                  </Box>
                </LabeledList.Item>
                <LabeledList.Item label="Endurance">
                  <Box>
                    {node.endurance} | {node.endurance_change}
                  </Box>
                </LabeledList.Item>
                <LabeledList.Item label="Lifespan">
                  <Box>
                    {node.lifespan} | {node.lifespan_change}
                  </Box>
                </LabeledList.Item>
                <LabeledList.Item label="Weed Rate">
                  <Box>
                    {node.weed_rate} | {node.weed_rate_change}
                  </Box>
                </LabeledList.Item>
                <LabeledList.Item label="Weed Chance">
                  <Box>
                    {node.weed_chance} | {node.weed_chance_change}
                  </Box>
                </LabeledList.Item>
              </LabeledList>
              <Table.Cell />
            </Table.Row>
          ))}
        </Table>
      )}
    </Section>
  );
};


export const InsertedBeaker = (props) => {
  const { act, data } = useBackend();
  const { held_beaker, working } = data;
  const beaker_data = data.beaker || [];
  if (!held_beaker) {
    return !working && <NoticeBox info>Please insert a beaker.</NoticeBox>;
  }
  return (
    <Section
      title="Inserted Beaker"
      buttons={
        <Button
          icon="eject"
          disabled={!!working}
          onClick={() => act('eject_beaker')}
          content="Eject Beaker"
        />
      }
    >
      {!held_beaker && 'No Beaker detected.'}
      {!!held_beaker && 'Beaker detected.'}
    </Section>
  );
};


export const InfuseButton = (props) => {
  const { act, data } = useBackend();
  const { working, seed, beaker } = data;
  return (
    <Button
      width="380px"
      height="20px"
      icon="eject"
      disabled={!!working && !seed && !beaker}
      onClick={() => act('infuse')}
      color="green"
      textAlign="center"
      align-content="center"
      content="Infuse Seed"
    />
  );
};

export const DamageBar = (props) => {
  const { act, data } = useBackend();
  const { combined_damage } = data;
  return (
    <Section>
      <ProgressBar
        color={combined_damage >= 60 ? 'bad' : 'good'}
        value={data.combined_damage / 100}
        align="center"
      >
        {`Infusion Damage: ${toFixed(data.combined_damage)}/ 100`}
      </ProgressBar>
    </Section>
  );
};

export const BotanyInfuser = (props) => {
  const { data } = useBackend();
  const [tab, setTab] = useSharedState('tab', 'infusion');
  const { working, timeleft, error } = data;
  return (
    <Window title="Plant Infusion" width={390} height={525}>
      <Window.Content>
        {!!error && <NoticeBox>{error}</NoticeBox>}
        {!!working && (
          <NoticeBox danger>
            <Flex direction="column">
              <Flex.Item mb={0.5}>Operation in progress.</Flex.Item>
              <Flex.Item>
                Time Left: <TimeFormat value={timeleft} />
              </Flex.Item>
            </Flex>
          </NoticeBox>
        )}
        <Section fitted>
          <Tabs>
            <Tabs.Tab
              selected={tab === 'infusion'}
              onClick={() => setTab('infusion')}
            >
              Infusion
            </Tabs.Tab>
          </Tabs>
        </Section>
        {tab === 'infusion' && <InfusionTab />}
      </Window.Content>
    </Window>
  );
};


export const InfusionTab = (props) => {
  const { data } = useBackend();
  const { working, timeleft, error } = data;
  return (
    <Section fitted>
      <InsertedSeedInfusion />
      <Flex.Item>
        <DamageBar />
      </Flex.Item>
      <InsertedBeaker />
      <InfuseButton />
    </Section>
  );
};
