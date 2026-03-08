---
name: disk-clean-audit
description: Shared disk cleanup audit guidance for macOS. Use when auditing disk usage with an info.md knowledge base, re-measuring capacity on every run, and proposing manual cleanup commands without executing deletion.
---

# Disk Clean Audit

## Overview

매 실행마다 용량 수치는 항상 새로 측정하고, 폴더의 의미/용도 분석은 `info.md`를 1차 기준으로 재사용한다.

핵심은 다음 두 줄이다.

- capacity is always fresh
- semantics are knowledge-base-first

이 상위 스킬은 공통 계약을 정의한다. 서비스별 패키징이 필요하면 아래 변형을 선택한다.

- `disk-clean-audit-chatgpt`
- `disk-clean-audit-claude`
- `disk-clean-audit-gemini`

## Non-Negotiables

- 절대 삭제/정리 실행 금지: `rm`, `mv`, `trash`, `find -delete`, `brew cleanup`, `docker system prune`, `npm cache clean`, `pip cache purge` 등 실제 정리/삭제 실행 금지
- `sudo` 직접 실행 금지
- `info.md` 외 파일 수정 금지
- 모든 출력은 한국어

## Execution Contract

1. 시작 시 `info.md`를 먼저 읽는다. 없으면 새로 만든다.
2. 아래 용량 명령은 매번 반드시 새로 실행한다.
   - `date`
   - `sw_vers`
   - `df -h /`
   - `df -h`
   - `du -x -d 1 / 2>/dev/null | sort -hr | head -n 80`
3. 폴더 의미/용도는 `info.md` 기록을 우선 사용한다.
   - 이미 근거 충분: 재분석하지 않고 용량만 갱신
   - 근거 부족/신규/급격한 변화: 그 경로만 깊게 조사
4. 루트 하위의 대용량 경로와 의미 있는 경로를 우선 본다.
   - `/Users`
   - `/Library`
   - `/private`
   - `/Applications`
   - `/opt`
   - `/usr/local`
   - `/opt/homebrew`
   - `/Volumes`
5. 깊은 조사 시에도 "용량 재측정"과 "의미 재분석"을 분리한다.
   - 용량: 항상 최신화
   - 의미: 필요한 경로에만 추가 근거 보강

## Folder Analysis Rules

- 의미 추정은 폴더명 단독 판단 금지
- 내부 구조, 대표 파일, 최근 수정 시각, 로컬 문서/코드로 근거 확보
- 불확실하면 `safe` 금지, `caution` 또는 `forbidden`
- `Permission denied` 또는 `Operation not permitted`는 `restricted`로 기록하고 반복 시도 금지

## Permission Handling Rules

- 모든 조사는 기본적으로 `sudo` 없이 읽기 전용으로 수행한다.
- `restricted` 경로는 반복 시도하거나 우회하지 않는다.
- 해당 경로에 대해서는 사용자가 직접 실행할 확인 명령만 제안한다.
- 권한 부족으로 인해 스캔이 불완전하면 최종 보고서에 반드시 `권한 때문에 미확인된 경로` 섹션을 포함한다.

## Deep Investigation Rules

기록이 없는 대용량 폴더 또는 기록이 불완전한 폴더만 깊게 조사한다.

필요 시 아래 방식으로 조사한다.

- `du -x -d 2 "$path" 2>/dev/null | sort -hr | head -n 80`
- 필요하면 `du -x -d 3 "$path" 2>/dev/null | sort -hr | head -n 80`
- `ls -lah "$path"`
- 대표 파일, 하위 디렉터리, 확장자 패턴 확인
- 최근 수정 시각 확인
- 관련 설정 파일, 패키지 메타데이터, 앱 식별자 흔적 확인

우선적으로 찾을 것:

- `README*`
- `docs/`
- `package.json`
- `Cargo.toml`
- `pyproject.toml`
- `requirements.txt`
- `go.mod`
- `Dockerfile`
- `docker-compose.yml`
- `.env.example`
- 앱 설정 파일
- 로그 파일

## Additional Investigation Rules

- 폴더명, 파일명, 확장자, 번들 ID, 패키지명, 레포 이름, 설정 파일 이름을 단서로 용도를 추정한다.
- 로컬에 관련 프로젝트 코드나 문서가 있으면 반드시 우선 확인한다.
- 특정 폴더가 어떤 앱이나 도구가 만든 것인지 확실하지 않으면 웹 검색을 사용한다.
- 웹 검색 우선순위:
  - 공식 문서
  - 공식 GitHub 저장소
  - 프로젝트 README 또는 문서
  - 신뢰할 수 있는 기술 문서
- 웹 검색 결과는 짧게 요약하고 어떤 근거로 판단했는지 기록한다.
- 웹 검색으로도 확실하지 않으면 추정이라고 명시하고 `caution`으로 둔다.
- 이미 `info.md`에 충분한 근거가 있는 폴더는 같은 웹 검색을 반복하지 않는다.
- 웹 검색과 로컬 문서 확인은 폴더 의미가 불명확할 때만 수행하고, 이미 기록된 근거를 불필요하게 반복하지 않는다.

## Classification Rules

- `safe`
  - 캐시, 로그, 임시 파일, 휴지통, 재생성 가능한 빌드 산출물, 오래된 다운로드 복사본, 명백한 백업 찌꺼기
- `caution`
  - Docker/Colima/VM 이미지, 시뮬레이터 데이터, 언어 패키지 캐시, 앱 지원 폴더, 모바일 백업, 대형 아카이브, 클라우드 동기화 데이터, 용도는 파악됐지만 영향이 남아 있는 폴더
- `forbidden`
  - `/System`, `/bin`, `/sbin`, `/usr` 핵심 경로, `/private/var/db`, 활성 프로젝트 저장소, 데이터베이스/볼륨, 메일/사진/음악 라이브러리, `.ssh`, 각종 설정 디렉터리, 용도를 충분히 검증하지 못한 중요 경로
- `restricted`
  - 권한 부족으로 충분히 확인하지 못한 경로

## info.md Update Rules

- 같은 경로 중복 섹션 생성 금지, 기존 섹션 갱신
- 파일 상단에는 마지막 전체 스캔 시각, OS 버전, 주요 디스크 요약을 둔다.
- 필수 필드 유지:
  - `size`
  - `classification`
  - `purpose`
  - `owner_or_related_app`
  - `created_by`
  - `current_usage`
  - `risk_if_removed`
  - `evidence`
  - `local_docs_or_code_checked`
  - `web_sources_checked`
  - `cleanup_advice`
  - `verify_commands`
  - `suggested_manual_commands`
  - `last_checked`
  - `confidence`
- 이번 실행에서 바뀐 사실만 갱신
  - 용량과 시각: 항상 갱신 대상
  - 의미와 용도: 신규 근거가 있을 때만 갱신

각 경로는 아래 형식으로 기록한다.

## /absolute/path
- size:
- classification: safe | caution | forbidden | restricted
- purpose:
- owner_or_related_app:
- created_by:
- current_usage:
- risk_if_removed:
- evidence:
- local_docs_or_code_checked:
- web_sources_checked:
- cleanup_advice:
- verify_commands:
- suggested_manual_commands:
- last_checked:
- confidence:

기록 작성 규칙:

- `purpose`에는 실질적 목적을 한 줄로 적는다.
- `created_by`에는 생성한 앱, 도구, 프로젝트를 적는다.
- `current_usage`에는 지금 어떤 흐름에서 쓰이는지 적는다.
- `risk_if_removed`에는 삭제 또는 정리 시 영향 가능성을 적는다.
- `evidence`에는 폴더 구조, 대표 파일, 로그, 메타데이터, 웹 검색 근거를 요약한다.
- `local_docs_or_code_checked`에는 확인한 로컬 문서나 코드 경로를 적는다.
- `web_sources_checked`에는 확인한 공식 문서, 저장소, 검색 결과를 짧게 적는다.
- 확실하지 않은 내용은 추정이라고 표시한다.

## Reporting Rules

항상 다음 순서로 보고한다.

1. 전체 요약
2. 기존 기록에서 재사용한 폴더
3. 이번에 새로 조사한 폴더
4. 정리 후보
   - 경로
   - 현재 크기
   - 무엇이 만들었고 무엇에 쓰는지
   - 왜 비교적 정리 가능해 보이는지
   - 먼저 확인할 명령
   - 사용자가 직접 실행할 명령
5. 주의, 금지, 권한 제한 폴더
6. `info.md`에 추가 또는 수정한 내용 요약

폴더 기반 스캔으로 설명되지 않는 사용량은 APFS snapshot, swap, sleepimage 가능성을 언급하고 확인 명령만 제시한다.

## Shell Command Proposal Rules

- 항상 먼저 확인 명령을 제시하고 그 다음에 수동 정리 명령을 제시한다.
- 명령은 경로를 명시적으로 적고 위험한 와일드카드는 피한다.
- 캐시, 로그, 임시 폴더는 필요할 때만 `rm -rf "정확한경로"` 형태를 사용자 수동 실행용으로 제안할 수 있다.
- 사용자 데이터나 판단 여지가 있는 폴더는 `mv "정확한경로" ~/.Trash/` 같은 덜 파괴적인 대안을 우선 제안한다.
- `sudo`가 필요한 명령은 직접 실행하지 말고 검토용 또는 사용자 수동 실행용으로만 제안한다.

## Quick Checklist

- [ ] 용량 명령을 이번 실행에서 다시 돌렸는가?
- [ ] 의미와 용도는 `info.md`를 우선 재사용했는가?
- [ ] 신규, 불완전, 급변 경로만 깊게 봤는가?
- [ ] 삭제 명령을 실행하지 않았는가?
- [ ] `info.md`만 수정했는가?
