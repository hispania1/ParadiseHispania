import { Window } from '../layouts';
import {
  Box,
  Button,
  Section,
  LabeledList,
} from '../components';
import { useBackend } from '../backend';

export const cargoupgrades = (props, context) => {
  const { act } = useBackend(context);
  return (
    <Window theme="syndicate">
      <Window.Content>
        <Box>Hello World</Box>
        <Section>
        <LabeledList title={"Hacking attack to station"}>
        <LabeledList.Item label="Status:">
        <Button
                icon="coins"
                content=" Start draining money "
                onClick={() => act('money_loss')}
        />
        </LabeledList.Item>
        </LabeledList>
        </Section>
        <Section>
          <Box>10010101100101010101001010101010010101010100101010
          100101010110010101010100101010101001010101010010101010
          100101010101001010101010010101010100101010101001010010</Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
