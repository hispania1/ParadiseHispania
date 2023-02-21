import { Window } from '../layouts';
import {
  Box,
  Button,
  Section,
  ProgressBar,
  LabeledList,
} from '../components';
import { useBackend } from '../backend';

export const bfl_emitter = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window>
      <Window.Content>
        <Section>
        <LabeledList>

        {data.receiver === 0 && (<LabeledList.Item label="Alert" color="red">
          Not Synced with a receiver!
        </LabeledList.Item>)}

        {data.receiver === 1 && (<LabeledList.Item label="Alert" color="green">
          Synced
        </LabeledList.Item>)}

        {data.state === 1 && (<LabeledList.Item label="Status">
          Drilling..
        </LabeledList.Item>)}

        {data.state === 0 && (<LabeledList.Item label="Status">
          Idle
        </LabeledList.Item>)}

        <LabeledList.Item label="Receiver">
        <Button
                icon="sync"
                content=" Syncronize "
                onClick={() => act('sync')}
                disabled={data.state === 1}
        />
        </LabeledList.Item>

        {data.state === 0 && (<LabeledList.Item label="Action">
        <Button
                icon="crosshairs"
                content=" Start drilling "
                color="red"
                onClick={() => act('activate')}
        />
        </LabeledList.Item>
        )}

        {(<LabeledList.Item label="Collected plasma">
          <ProgressBar
            value={data.plasma_collected}
            minValue={0}
            maxValue={500}
            ranges = {{
              good: [500,Infinity],
              average: [51,499],
              bad: [-Infinity,50],
              }}>
            {data.plasma_collected} Units
          </ProgressBar>
        </LabeledList.Item>)}

        {data.state === 1 && (
        <LabeledList.Item label="Action">
        <Button
                icon="times"
                content=" Stop drilling "
                onClick={() => act('deactivate')}
        />
        </LabeledList.Item>
        )}

        </LabeledList>
        </Section>

        <Section>
        {data.receiver === 0 && (<Box>WARNING:
        Drilling without a synced emitter is extremely dangerous
        for the mining sector, the beam can go loose. </Box>)}
        </Section>


        <Section>
        {data.receiver === 0 && data.state === 1 &&(<LabeledList.Item color="red">
        DANGER LASER HAS NO DIRECTION IN LAVALAND
        </LabeledList.Item>)}
        </Section>

      </Window.Content>
    </Window>
  );
};
