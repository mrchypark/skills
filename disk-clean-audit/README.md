# Disk Clean Audit

`disk-clean-audit`는 macOS 저장공간을 읽기 전용으로 감사하고, `info.md`를 지식 베이스로 누적 관리하면서, 사람이 직접 실행할 정리 명령만 제안하는 스킬 패밀리다.

## Included Skills

- `disk-clean-audit`: 공통 규칙과 감사 계약
- `disk-clean-audit-chatgpt`: ChatGPT/Codex용 변형
- `disk-clean-audit-claude`: Claude용 변형
- `disk-clean-audit-gemini`: Gemini용 변형

## Install As Skills

Codex skills 디렉터리에 이 폴더를 그대로 복사한다.

```bash
mkdir -p ~/.codex/skills
cp -R disk-clean-audit ~/.codex/skills/disk-clean-audit
```

설치 후에는 상황에 맞는 변형을 사용한다.

- ChatGPT/Codex 기준: `$disk-clean-audit-chatgpt`
- Claude 기준: `$disk-clean-audit-claude`
- Gemini 기준: `$disk-clean-audit-gemini`
- 공통 규칙을 먼저 보고 싶으면: `$disk-clean-audit`

## What The Skill Does

- 루트 디스크 사용량을 새로 측정한다.
- `info.md`를 1차 정보원으로 사용한다.
- 이미 기록된 폴더는 재분석하지 않고, 정보가 약하거나 새로 등장한 경로만 더 깊게 조사한다.
- 폴더 의미를 로컬 코드, 문서, 대표 파일, 최근 수정 시각, 필요 시 웹 검색으로 추정한다.
- 실제 삭제는 절대 실행하지 않고, 사용자가 직접 검토할 확인 명령과 수동 정리 명령만 제안한다.

## Automation Installation

이 스킬은 반복 감사 자동화와 잘 맞는다. 자동화 프롬프트에는 스케줄 설명을 넣지 말고, 작업 자체만 넣는다.

권장 automation 설정 값:

- 이름: `Disk Clean Audit`
- 작업 디렉터리: 감사할 macOS 루트 또는 `info.md`를 관리할 작업 폴더
- 상태: `ACTIVE`
- 출력 기대값: 한국어 보고서 + `info.md` 갱신

권장 automation prompt 예시:

```md
Use $disk-clean-audit-chatgpt to audit macOS disk usage in read-only mode.

Read `info.md` first, refresh all required capacity commands on this run, reuse existing folder semantics when the evidence is already sufficient, and only investigate new, incomplete, sharply changed, or unclear large paths more deeply.

Do not execute deletion, cleanup, trash, move, prune, or sudo commands. Only update `info.md`.

Return the final report in Korean with these sections:
1. 전체 요약
2. 기존 기록에서 재사용한 폴더
3. 이번에 새로 조사한 폴더
4. 정리 후보
5. 주의/금지/권한 제한 폴더
6. `info.md` 수정 요약
```

설치 후 로컬 파일 경로를 직접 적고 싶다면 저장소 체크아웃 경로가 아니라 설치 경로를 사용한다.

```text
~/.codex/skills/disk-clean-audit/chatgpt/SKILL.md
```

## Automation Notes

- 자동화는 항상 inbox item을 열도록 구성하는 것이 좋다.
- 스케줄은 작업 특성상 주간 1회 또는 하루 1회가 무난하다.
- `info.md` 위치를 고정하면 이전 감사 결과를 계속 재사용할 수 있다.
- 권한 부족 경로는 `restricted`로 기록하고, 자동화에서도 우회하지 않게 유지한다.

## Recommended Workspace Layout

감사 결과를 별도 폴더에 모으려면 예를 들어 이런 식으로 둘 수 있다.

```text
disk-clean-audit-workspace/
├── info.md
└── notes/
```

자동화의 `cwd`를 이 작업 폴더로 두고, 보고서와 `info.md`를 계속 누적 관리하는 방식이 가장 단순하다.
