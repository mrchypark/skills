# Disk Clean Audit

`disk-clean-audit`는 macOS 저장공간을 읽기 전용으로 감사하고, `info.md`를 지식 베이스로 누적 관리하면서, 사람이 직접 실행할 정리 명령만 제안하는 Codex 스킬이다.

이 저장소에서는 `skills/domain/disk-clean-audit/` 아래에 있다.

## Install

```bash
sh install/global-install.sh "$(pwd)"
sh install/verify-install.sh "$(pwd)"
```

프로젝트에 직접 넣고 싶으면:

```bash
sh install/project-bootstrap.sh "$(pwd)" /path/to/project
```

## What The Skill Does

- 루트 디스크 사용량을 새로 측정한다.
- `info.md`를 1차 정보원으로 사용한다.
- 이미 기록된 폴더는 재분석하지 않고, 정보가 약하거나 새로 등장한 경로만 더 깊게 조사한다.
- 폴더 의미를 로컬 코드, 문서, 대표 파일, 최근 수정 시각, 필요 시 웹 검색으로 추정한다.
- 실제 삭제는 절대 실행하지 않고, 사용자가 직접 검토할 확인 명령과 수동 정리 명령만 제안한다.
