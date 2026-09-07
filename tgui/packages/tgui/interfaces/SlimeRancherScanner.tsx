// THIS IS A OCULIS UI FILE
import type { CSSProperties } from 'react';
import {
  Box,
  DmIcon,
  Icon,
  NoticeBox,
  ProgressBar,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { capitalizeAll } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Requirement = {
  name: string;
  icon: string;
  icon_state: string;
};

type WantedItem = Requirement & {
  done: BooleanLike;
};

type WantedDrain = Requirement & {
  total: number;
  drained: number;
};

type Mutation = {
  color: string;
  color_hex: string;
  ready: BooleanLike;
  items: WantedItem[];
  drains: WantedDrain[];
};

// static data
type BuiltInNumberData = {
  max_growth: number;
  max_crossbreed_progress: number;
  max_powerlevel: number;
  max_nutrition: number;
  nutrition_starving: number;
  nutrition_hungry: number;
};

type BaseSlimeData = {
  scanned: BooleanLike;
  name: string;
  color: string;
  color_hex: string;
  sprite_icon: string;
  sprite_state: string;
  transparent: BooleanLike;
};

type SlimeInfoData = {
  mood_state: string | null;
  life_stage: string;
  health: number;
  max_health: number;
  nutrition: number;
  powerlevel: number;
  cores: number;
  growth: number;
};

type SlimeMutationData = {
  mutation_chance: number;
  crossbreed_modification: string | null;
  crossbreed_progress: number;
  mutations: Mutation[];
};

// i just split these into multiple subtypes then mushed them together bc like i thought one data type was just too fucking huge ~Lucy
type Data = {
  scanned: BooleanLike;
} & BaseSlimeData &
  SlimeInfoData &
  SlimeMutationData &
  BuiltInNumberData;

function SlimeName(props: { color: string; hex: string; suffix?: string }) {
  const { color, hex, suffix } = props;

  return (
    <Box className="SlimeRancherScanner__name">
      <Box
        className={`SlimeRancherScanner__swatch${color === 'rainbow' ? ' SlimeRancherScanner__swatch--rainbow' : ''}`}
        style={{ '--slime-color': hex } as CSSProperties}
      />
      <span>
        {capitalizeAll(color)}
        {suffix && ` ${suffix}`}
      </span>
    </Box>
  );
}

const SPRITE_SIZE = '64px';

/** The face is its own overlay in-game, so it gets its own layer sat on top of the body. */
function SlimePortrait(props: {
  icon: string;
  state: string;
  mood: string | null;
  transparent: BooleanLike;
}) {
  const { icon, state, mood, transparent } = props;
  return (
    <Box
      className={`SlimeRancherScanner__portrait${transparent ? ' SlimeRancherScanner__portrait--transparent' : ''}`}
    >
      <DmIcon
        icon={icon}
        icon_state={state}
        fallback={<Icon name="circle" size={3} />}
        width={SPRITE_SIZE}
        height={SPRITE_SIZE}
        className="SlimeRancherScanner__sprite"
      />
      {!!mood && (
        <DmIcon
          icon={icon}
          icon_state={mood}
          fallback={null}
          width={SPRITE_SIZE}
          height={SPRITE_SIZE}
          className="SlimeRancherScanner__sprite"
        />
      )}
    </Box>
  );
}

const REQUIREMENT_ICON_SIZE = '32px';

/** Fixed size so an odd-sized source icon can't shove one row out of line with its neighbors. */
function RequirementIcon(props: { requirement: Requirement }) {
  const { requirement } = props;

  return (
    <DmIcon
      icon={requirement.icon}
      icon_state={requirement.icon_state}
      fallback={<Icon name="question" />}
      width={REQUIREMENT_ICON_SIZE}
      height={REQUIREMENT_ICON_SIZE}
    />
  );
}

function MutationRow(props: { mutation: Mutation }) {
  const { mutation } = props;

  return (
    <Box className="SlimeRancherScanner__recipe">
      <Box className="SlimeRancherScanner__recipe-heading">
        <SlimeName color={mutation.color} hex={mutation.color_hex} />
        {!!mutation.ready && (
          <span className="SlimeRancherScanner__ready">
            <Icon name="check" /> Ready
          </span>
        )}
      </Box>
      <Box className="SlimeRancherScanner__requirements">
        {mutation.items.map((item) => (
          <Box
            key={item.name}
            className={`SlimeRancherScanner__requirement${item.done ? ' SlimeRancherScanner__requirement--done' : ''}`}
          >
            <RequirementIcon requirement={item} />
            <span className="SlimeRancherScanner__requirement-name">
              {item.name}
            </span>
            {!!item.done && (
              <Icon name="check" className="SlimeRancherScanner__completed" />
            )}
          </Box>
        ))}
        {mutation.drains.map((drain) => (
          <Box key={drain.name} className="SlimeRancherScanner__requirement">
            <RequirementIcon requirement={drain} />
            <Box className="SlimeRancherScanner__drain">
              <span>{drain.name}</span>
              <ProgressBar
                value={drain.drained}
                maxValue={drain.total}
                color={drain.drained >= drain.total ? 'good' : 'average'}
              >
                {drain.drained} / {drain.total}
              </ProgressBar>
            </Box>
          </Box>
        ))}
      </Box>
    </Box>
  );
}

function Vitals() {
  const { data } = useBackend<Data>();
  const {
    color,
    color_hex,
    sprite_icon,
    sprite_state,
    mood_state,
    transparent,
    life_stage,
    health,
    max_health,
    nutrition,
    max_nutrition,
    nutrition_starving,
    nutrition_hungry,
    powerlevel,
    max_powerlevel,
    cores,
    growth,
    max_growth,
    mutation_chance,
    crossbreed_modification,
    crossbreed_progress,
    max_crossbreed_progress,
    mutations,
  } = data;
  const anyReady = mutations.some((mutation) => !!mutation.ready);

  const starving = nutrition < nutrition_starving;
  const hungry = nutrition < nutrition_hungry;

  return (
    <Box className="SlimeRancherScanner__vitals">
      <Box className="SlimeRancherScanner__identity">
        <Box className="SlimeRancherScanner__portrait-well">
          <SlimePortrait
            icon={sprite_icon}
            state={sprite_state}
            mood={mood_state}
            transparent={transparent}
          />
        </Box>
        <Box className="SlimeRancherScanner__identity-text">
          <h1>
            <SlimeName color={color} hex={color_hex} suffix="slime" />
          </h1>
          <span className="SlimeRancherScanner__life-stage">
            {capitalizeAll(life_stage)}
          </span>
        </Box>
      </Box>
      {!!starving && (
        <NoticeBox danger>
          This slime is starving, feed the poor thing soon!
        </NoticeBox>
      )}
      {!starving && !!hungry && <NoticeBox>This slime is hungry.</NoticeBox>}
      <Box className="SlimeRancherScanner__meters">
        <Box className="SlimeRancherScanner__meter">
          <span>Health</span>
          <ProgressBar
            value={health}
            maxValue={max_health}
            ranges={{
              good: [max_health * 0.5, Infinity],
              average: [max_health * 0.25, max_health * 0.5],
              bad: [-Infinity, max_health * 0.25],
            }}
          >
            {health} / {max_health}
          </ProgressBar>
        </Box>
        <Box className="SlimeRancherScanner__meter">
          <span>Nutrition</span>
          {/* colored off the flags rather than a range, so it matches the game's own hunger thresholds */}
          <ProgressBar
            value={nutrition}
            maxValue={max_nutrition}
            color={starving ? 'bad' : hungry ? 'average' : 'good'}
          >
            {nutrition} / {max_nutrition}
          </ProgressBar>
        </Box>
        <Box className="SlimeRancherScanner__meter">
          <span>Growth</span>
          <ProgressBar value={growth} maxValue={max_growth}>
            {growth} / {max_growth}
          </ProgressBar>
        </Box>
        <Tooltip
          content={
            anyReady
              ? 'Chance this slime attempts a mutation when it splits.'
              : 'No mutations are currently available. This slime will split into more of its own color.'
          }
        >
          <Box className="SlimeRancherScanner__meter">
            <span>Mutation chance {!anyReady && <Icon name="lock" />}</span>
            <ProgressBar
              className={
                !anyReady
                  ? 'SlimeRancherScanner__instability--locked'
                  : undefined
              }
              value={mutation_chance}
              maxValue={100}
            >
              {mutation_chance}%
            </ProgressBar>
          </Box>
        </Tooltip>
      </Box>
      <Box className="SlimeRancherScanner__readings">
        <Box>
          <span>Electric charge</span>
          <strong>
            {powerlevel} / {max_powerlevel}
          </strong>
        </Box>
        <Box>
          <span>Cores</span>
          <strong>{cores}</strong>
        </Box>
      </Box>
      {!!crossbreed_modification && (
        <Box className="SlimeRancherScanner__meter">
          <h2>Core mutation</h2>
          <span>{crossbreed_modification}</span>
          <ProgressBar
            value={crossbreed_progress}
            maxValue={max_crossbreed_progress}
          >
            {crossbreed_progress} / {max_crossbreed_progress}
          </ProgressBar>
        </Box>
      )}
    </Box>
  );
}

function Mutations() {
  const { data } = useBackend<Data>();
  const { mutations } = data;
  const anyReady = mutations.some((mutation) => !!mutation.ready);

  if (mutations.length === 0) {
    return (
      <Box className="SlimeRancherScanner__mutations">
        <h2>Mutations</h2>
        <p>This slime has nowhere left to mutate to.</p>
      </Box>
    );
  }

  return (
    <Box className="SlimeRancherScanner__mutations">
      <h2>Mutations</h2>
      {!anyReady && (
        <NoticeBox info>
          No recipe is finished yet, so this slime will just split into more of
          its own color.
        </NoticeBox>
      )}
      <Box className="SlimeRancherScanner__recipes">
        {mutations.map((mutation) => (
          <MutationRow key={mutation.color} mutation={mutation} />
        ))}
      </Box>
    </Box>
  );
}

export const SlimeRancherScanner = () => {
  const { data } = useBackend<Data>();
  const { scanned } = data;

  return (
    <Window width={780} height={540} theme="slime_rancher_scanner">
      <Window.Content scrollable className="SlimeRancherScanner">
        {!scanned ? (
          <Box className="SlimeRancherScanner__empty">
            <Icon name="crosshairs" size={3} />
            <h1>No slime currently scanned.</h1>
            <p>Point the scanner at any slime you can see.</p>
          </Box>
        ) : (
          <>
            <Vitals />
            <Mutations />
          </>
        )}
      </Window.Content>
    </Window>
  );
};
