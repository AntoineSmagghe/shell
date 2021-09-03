#!/bin/zsh

FILE=$1

cat << EOF > /home/antoine/Documents/vimeet365/client/src/components/$FILE.stories.svelte
<script>
  import { Meta, Template, Story } from '@storybook/addon-svelte-csf';
  import $FILE from './$FILE.svelte';

  const defaultProps = {
    slot:  {
      id: 1,
      startDate: '2021-09-10T14:19:09.221Z',
      endDate: '2021-09-10T15:19:09.221Z',
    }
  };
</script>

<Meta
  title="Vimeet365/$FILE"
  parameters={defaultProps}
  component={$FILE}
/>

<Template let:args>
  <$FILE {...args} />
</Template>

<div class="w-144">
  <Story name="Basic" args={{ ...defaultProps }} />
</div>
EOF