사업 아이디에이션용 키워드 큐레이션을 수행해라.

- `trend_researcher`를 2개 병렬로 spawn해서 각각 최근 영문 웹 소스를 탐색하라.
- 두 researcher는 서로 다른 검색 각도를 사용하라.
  - 하나는 `emerging trends`, `workflow shift`, `behavior change` 중심
  - 하나는 `unmet needs`, `controversial startups`, `trust or friction` 중심
- 필요한 경우 long-running 검색이나 대기에는 built-in `monitor` 역할을 사용하라.
- 두 researcher 결과를 모두 수집한 뒤 `keyword_curator`가 최종 2~3개 키워드를 제안하라.
- 최종 결과는 보통 `evidence_backed` 1~2개와 `wildcard` 1개로 구성하라.
- 각 `evidence_backed` 키워드에는 source title, URL, 가능하면 발행일을 포함하라.
- `wildcard`는 완전히 엉뚱한 단어가 아니라 사업적으로 해석 가능한 controlled-random 키워드여야 한다.
- 결과는 한국어로 작성하라.
- 마지막에는 바로 브레인스토밍에 쓸 수 있는 한 줄 사업 방향을 덧붙여라.

입력 토픽: <여기에 토픽>
입력 컨텍스트: <여기에 타깃, 제약, 산업 맥락>
