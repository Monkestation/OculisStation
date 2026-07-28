import { marked } from 'marked';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';

type MarkdownViewerData = {
  title: string;
  content: string;
  author: string;
};

export const MarkdownViewer = (_: any) => {
  const { data } = useBackend<MarkdownViewerData>();
  return (
    <Window theme="paper" title={data.title} width={420} height={500}>
      <Window.Content scrollable backgroundColor={'#FFFFFF'}>
        <MarkdownRenderer content={data.content} />
      </Window.Content>
    </Window>
  );
};

type MarkdownRendererProps = {
  content: string;
  sanitize?: boolean;
};

export const MarkdownRenderer = (props: MarkdownRendererProps) => {
  let { content, sanitize } = props;

  content = marked(content, { async: false });
  if (sanitize) {
    // content = sanitizeText(content, /* advHtml = */ false); // OCULIS EDIT REMOVAL
    // OCULIS EDIT ADDITION START
    const result = sanitizeText(content, /* advHtml = */ false);
    if (typeof result === 'object' && result !== null) {
      content = result.sanitized
    }
    else {
      content = result
    }
    // OCULIS EDIT ADDITION END
  }

  return <div dangerouslySetInnerHTML={{ __html: content }} />;
};

MarkdownRenderer.defaultProps = {
  sanitize: true,
};
