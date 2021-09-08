#!/bin/zsh

FILE=$1

cat << EOF > /home/antoine/Documents/vimeet365/client/src/components/$FILE.stories.svelte
<script>
  import { Meta, Template, Story } from '@storybook/addon-svelte-csf';
  import $FILE from './$FILE.svelte';

  const defaultProps = {};
</script>

<Meta
  title="Vimeet365/$FILE"
  parameters={defaultProps}
  component={$FILE}
/>

<Template let:args>
  <$FILE {...args} />
</Template>

<Story name="Basic" args={{ ...defaultProps }} />

EOF