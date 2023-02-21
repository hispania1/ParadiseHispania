import { Window } from '../layouts';
import {
  Box,
  Button,
  Section,
  NoticeBox,
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

          {data.receiver === 0 && data.state === 1 &&(<NoticeBox danger p={1.5}>
          <b>WARNING:</b> Laser is loose in lavaland!
          </NoticeBox>)}

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

        {data.state === 0 && data.receiver === 0 && (<LabeledList.Item label="Action">
        <Button
                icon="crosshairs"
                content=" Start drilling "
                color="red"
                onClick={() => act('activate')}
        />
        </LabeledList.Item>
        )}

        {data.state === 0 && data.receiver === 1 && (<LabeledList.Item label="Action">
        <Button
                icon="crosshairs"
                content=" Start drilling "
                color="green"
                onClick={() => act('activate')}
        />
        </LabeledList.Item>
        )}

          {data.state === 1 && (
          <LabeledList.Item label="Action">
          <Button
                  icon="times"
                  content=" Stop drilling "
                  onClick={() => act('deactivate')}
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


        </LabeledList>
        </Section>

      </Window.Content>
    </Window>
  );
};
