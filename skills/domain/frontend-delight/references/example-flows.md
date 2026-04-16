# Example Flows

Use these examples to calibrate the tone, intake order, and brief quality.

## 1. Vague landing page request

### User

```text
우리 AI 회의 요약 서비스 랜딩 페이지를 아주 세련되게 만들어줘.
```

### Assistant first response

```text
먼저 방향을 잠그겠습니다. 이 페이지의 첫 화면에서 사용자가 바로 느껴야 하는 건 무엇인가요: 신뢰, 속도, 프리미엄, 팀 생산성 중 어디에 더 가깝습니까?
```

### User

```text
팀 생산성과 신뢰.
```

### Assistant second response

```text
좋습니다. 시각 방향은 셋 중 하나로 잡는 게 빠릅니다.

1. Editorial Minimal: 넓은 여백, 큰 타이포, 차분한 프리미엄 톤
2. Sharp Product: 제품 중심, 또렷한 그리드, 강한 명료성
3. Expressive Motion: 더 기억에 남는 모션과 깊이감, 대신 절제 유지

현재 서비스에 더 맞는 쪽을 골라 주세요. 참고할 사이트나 스크린샷이 있으면 같이 주세요.
```

### User

```text
2번. 참고는 Linear, Stripe 정도.
```

### Assistant brief

```text
Design brief
- Surface: 신규 마케팅 랜딩 페이지
- User + job: 바쁜 팀 리드가 서비스를 10초 안에 이해하고 데모 요청 또는 가입을 판단
- Primary action: 데모 요청 또는 무료 체험 시작
- Visual thesis: 또렷한 제품 그리드와 절제된 대비를 중심으로, 신뢰감 있는 팀 생산성 도구처럼 보이게 한다
- Content plan: hero로 제품 가치 제안 제시, support section으로 사용 맥락 정리, product detail로 자동 요약 흐름 시각화, proof로 팀 신뢰 요소 제시, CTA로 전환
- Interaction thesis: hero 요소의 짧은 stagger reveal, product preview의 가벼운 depth motion, CTA 영역의 미세한 hover emphasis
- Design tokens: 밝은 중성 배경, 짙은 본문 텍스트, 제한된 블루 계열 accent, display/headline/body/caption 역할 분리
- Asset plan: 로고와 실제 제품 스크린샷 필요, 없으면 제품 UI 모크를 임시 제작
- Constraints: 모바일 우선 붕괴 없이 동작, 기존 디자인 시스템 없으면 CSS 변수로 토큰 정의
- Explicit assumptions: 현재는 B2B SaaS 톤으로 가정, 고객 로고와 실제 후기 문구는 아직 없음

Approve this direction, or tell me what to change before I start building.
```

## 2. Existing dashboard redesign

### User

```text
지금 운영 대시보드가 너무 구식이야. 현대적으로 다시 만들어줘.
```

### Assistant first response

```text
새 스타일을 얹기 전에 현재 운영자가 이 화면에서 가장 먼저 해야 하는 일이 무엇인지부터 잡겠습니다. 첫 30초 안에 확인하거나 조치해야 하는 핵심 작업이 뭔가요?
```

### User

```text
장애 징후 확인하고, 이상 지표가 있으면 바로 상세로 들어가야 해.
```

### Assistant second response

```text
그럼 마케팅형 화면이 아니라 operator workspace로 가야 합니다. 현재 화면 캡처나 컴포넌트 라이브러리, 사용 중인 차트/테이블 컴포넌트가 있으면 먼저 보여 주세요.
```

### User

```text
MUI 쓰고 있고, 화면 캡처는 이따 줄게. 차트는 recharts.
```

### Assistant brief

```text
Design brief
- Surface: 기존 운영 대시보드 리디자인
- User + job: 운영자가 이상 징후를 빠르게 스캔하고 즉시 상세 분석으로 진입
- Primary action: 위험 신호 식별 후 drill-down
- Visual thesis: 차분한 밀도와 강한 정보 계층으로, 통제감 있는 운영 콘솔처럼 보이게 한다
- Content plan: 상단 상태 개요, 메인 워크서피스에 핵심 시계열과 이벤트 테이블, 우측 보조 컨텍스트 또는 inspector, 필터와 시간 범위는 항상 가깝게 배치
- Interaction thesis: 필터 변경 시 즉각적 상태 피드백, 경고 행 강조, drill-down affordance를 명확하게 노출
- Design tokens: 저채도 중성 팔레트, 의미 있는 상태색만 강하게 사용, 높은 가독성 타이포 스케일, 패널보다 레이아웃 구조 중심
- Asset plan: 기존 화면 캡처와 실제 지표 이름 필요, 없으면 구조만 먼저 정리
- Constraints: 기존 MUI와 recharts 유지, 카드 난립 금지, 모바일은 핵심 확인 흐름만 유지
- Explicit assumptions: 현재 사용자는 내부 운영자이며, 브랜딩보다 가독성과 속도가 우선

Approve this direction, or tell me what to change before I start building.
```

## 3. Fast path with explicit assumptions

### User

```text
시간 없으니까 대충 감으로 멋지게 회원가입 화면 만들어줘.
```

### Assistant response

```text
빠르게 가겠습니다. 다만 바로 코딩하지 않고 가정을 먼저 잠급니다.

Design brief
- Surface: 신규 회원가입 화면
- User + job: 신규 사용자가 최소 마찰로 계정을 만들고 바로 첫 진입을 완료
- Primary action: 이메일 또는 소셜 로그인으로 가입 완료
- Visual thesis: 밝고 정돈된 단일 컬럼 구조에, 신뢰감 있는 제품 톤과 절제된 하이라이트를 얹는다
- Content plan: 짧은 가치 제안, 가입 폼, 보조 신뢰 요소, 로그인 전환 링크
- Interaction thesis: 입력 포커스 상태를 또렷하게, 오류 메시지는 즉시 노출, 제출 전후 상태 변화는 짧고 명확하게
- Design tokens: 밝은 배경, 고대비 텍스트, 제한된 accent, 과장되지 않은 radius와 shadow
- Asset plan: 실제 브랜드 자산이 없으므로 임시 워드마크와 카피를 사용
- Constraints: 데스크톱과 모바일 모두 자연스럽게 동작, 접근성 기본 준수
- Explicit assumptions: 소셜 로그인은 Google 1개만, 법적 문구와 세부 브랜드 가이드는 아직 없음

이 가정으로 바로 진행할까요, 아니면 브랜드 톤이나 가입 방식만 한 줄로 수정할까요?
```

## What good looks like

- The first question narrows the design instead of asking for everything at once.
- The assistant offers concrete options when the user is vague.
- The brief is short, visual, and implementation-ready.
- The assistant asks for approval before coding.
- Existing system constraints are preserved when they exist.
