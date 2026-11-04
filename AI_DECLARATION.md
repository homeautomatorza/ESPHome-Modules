# AI Declaration

Before I begin, let's be honest: AI is here to stay, at least for now. This is neither Dune nor Foundation, where thinking machines have been banned.

I am a strong believer that this technology, used as a tool for the betterment of humankind, is essential. But I do not want to go down the rabbit hole of the politics and philosophies of the subject here. However, I want to be 100% transparent.

I've always been of the opinion that if there is a tool at an approachable price that will help me achieve a better product, I should use it. This is no different with AI.

This project is 5 years old, and I introduced AI into my workflow when I started the 2026 version of the framework. As you can imagine, a good part of the project was already written by then, and no AI was involved.

AI has been a substantial part of redeveloping this framework. I write most of the code and do most of the electronics work, but not all of it without assistance. Sometimes we write or improve code together; sometimes I use AI as a teacher to work through something I do not yet understand. Its contribution also includes reviewing the framework, helping investigate problems, and developing standards with me. The AI develops the documentation, which I review. I bring the project direction, make the final decisions and personally test the hardware.

## How and What I use AI for

I think it's important that you understand how I use AI and what I use it for, so here is a simple list:

- Documentation   
Including the new front matter, project documentation and the wiki.
- Configuration validation  
AI helps me review YAML syntax, ESPHome configuration structure and obvious code errors. ESPHome configuration checks confirm whether the configuration is accepted; they do not prove that firmware compiles or hardware works.
- Compile validation  
I usually ask the AI to run a test compile first. If there are errors, we work through them together. After a successful test compile, I compile the firmware myself, deploy it to the physical device and test its behaviour. A successful test compile alone does not establish hardware validation.
- When I am really stuck and need help  
Cooperative coding.
- Revalidating the code for deprecations or improvements at each major ESPHome update.  
At each major ESPHome update, I ask the AI to review the release notes and check the framework for breaking changes, deprecated options and useful improvements. We work through relevant changes together and validate the affected configurations, recording what was checked and any failures or exclusions.
- Commits, pushes and repository maintenance.  
The AI handles commits, pushes and repository maintenance for me, with publication subject to my approval. Git and I are not friends, and this is an area where AI helps me work faster and make fewer mistakes.

I often develop new modules inside the master device file first because I find it easier to work that way. Once the code works, I ask the AI to extract it into a reusable module and add the front matter using our established standards. This is refactoring code I have already written, although moving it can require changes to includes and substitutions. We check the extracted module to confirm it still behaves as intended.

In the end, I check everything and edit where necessary. The AI is more of an assistant to me than anything else.

It reviews my work, I review its work, and I have the final say.
No file says "Hardware validated" until I have personally validated the compiled version on a device and seen it working. I often even add web screenshots and logs for that purpose.

I've also created or integrated skills to increase quality and adhere to our agreed standards. I may share these in the future if I feel they would be useful to anyone.

Being that I suffer from chronic pain (CRPS/RSD), the rise of AIs has been very helpful to me. It allows me to give you a more polished product at the end, with strong documentation and some extras I could never do without it. It allows me to focus on the code and the electronics as opposed to the rest.

And now you know how I use the AI in my workflow.

And if you are wondering which LLM I use, I am currently using Codex, but I have used others. I personally did not like the way they interacted with me, and I want to avoid any friction.

> [!note] 
I wrote the original draft of this declaration, and Alfred (my AI assistant) and I worked on it in tandem, reviewing the wording and correcting it together to accurately reflect how we work.
