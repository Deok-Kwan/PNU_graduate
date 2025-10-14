# GitHub-Overleaf 연동 가이드

학위논문 LaTeX 프로젝트를 GitHub와 Overleaf에 연동하는 완전한 가이드입니다.

## 목차
1. [프로젝트 현황](#프로젝트-현황)
2. [GitHub 저장소 설정](#github-저장소-설정)
3. [Overleaf 연동 방법](#overleaf-연동-방법)
4. [작업 흐름 (Workflow)](#작업-흐름-workflow)
5. [문제 해결](#문제-해결)

---

## 프로젝트 현황

### 현재 상태
- **위치**: `/Users/yangdeokkwan/Documents/Overleaf_Projects/학위논문_DK`
- **Git 상태**: 초기화되지 않음 (새로 시작)
- **프로젝트 크기**: 약 6.4MB
- **주요 파일**:
  - `main.tex` (메인 논문 파일)
  - `Ref.bib` (참고문헌)
  - `figures/` (11개 이미지 파일, ~900KB)
  - LaTeX 빌드 파일들 (제외 예정)

### 파일 구성 분석
```
학위논문_DK/
├── main.tex              # 메인 문서 (48KB)
├── Ref.bib              # 참고문헌 (4KB)
├── list_of_figures.tex  # 그림 목록
├── list_of_tables.tex   # 표 목록
├── figures/             # 이미지 디렉토리
│   ├── *.png           # 11개 PNG 파일
└── [빌드 파일들]        # .aux, .log, .pdf 등 (Git에서 제외)
```

---

## GitHub 저장소 설정

### 단계 1: GitHub에서 새 저장소 만들기

1. **GitHub 웹사이트 접속**
   - https://github.com 로그인

2. **새 저장소 생성**
   - 오른쪽 상단 `+` 클릭 → "New repository"
   - **Repository name**: `thesis` 또는 `학위논문` (영문 추천)
   - **Description**: "Master's/PhD Thesis in LaTeX"
   - **Visibility**:
     - `Private` (권장 - 논문은 비공개)
     - `Public` (졸업 후 공개하려면)
   - **초기화 옵션**: 모두 체크 해제 (로컬에서 이미 있음)
   - "Create repository" 클릭

3. **저장소 URL 복사**
   - 예: `https://github.com/yangdeokkwan/thesis.git`

### 단계 2: 로컬에서 Git 초기화

터미널에서 다음 명령어 실행:

```bash
# 프로젝트 디렉토리로 이동
cd "/Users/yangdeokkwan/Documents/Overleaf_Projects/학위논문_DK"

# Git 초기화
git init

# 빌드 파일 정리 (선택사항)
rm -f *.aux *.log *.fls *.fdb_latexmk *.synctex.gz *.bbl *.blg

# 파일 추가
git add .

# 첫 커밋
git commit -m "Initial commit: 학위논문 LaTeX 프로젝트 초기 버전"

# GitHub 저장소 연결 (자신의 URL로 변경)
git remote add origin https://github.com/yangdeokkwan/thesis.git

# GitHub에 푸시
git branch -M main
git push -u origin main
```

### 단계 3: GitHub 저장소 확인

브라우저에서 GitHub 저장소 접속하여 파일이 올라갔는지 확인:
- `main.tex`, `Ref.bib`, `figures/` 등이 보여야 함
- `.aux`, `.log` 등 빌드 파일은 보이지 않아야 함

---

## Overleaf 연동 방법

### 방법 A: Overleaf Premium (추천) 🌟

**장점**: 양방향 자동 동기화, Git 통합, 무제한 협업자

#### A-1. 새 Overleaf 프로젝트 생성

1. **Overleaf 로그인**
   - https://www.overleaf.com

2. **GitHub에서 가져오기**
   - 좌측 메뉴 "New Project" 클릭
   - "Import from GitHub" 선택
   - GitHub 계정 연동 (처음이면 인증)
   - `thesis` 저장소 선택
   - "Import to Overleaf" 클릭

3. **자동 동기화 설정**
   - 프로젝트 열기 → 좌측 메뉴 (☰) → "GitHub"
   - "Push to GitHub" / "Pull from GitHub" 버튼 확인
   - **자동 동기화 활성화** (Premium 기능)

#### A-2. 기존 Overleaf 프로젝트 연동

만약 이미 Overleaf에 프로젝트가 있다면:

1. **Overleaf에서 Git URL 확인**
   - 프로젝트 메뉴 (☰) → "Git"
   - Git clone URL 복사 (예: `https://git.overleaf.com/abc123xyz`)

2. **로컬에서 Overleaf 리모트 추가**
```bash
cd "/Users/yangdeokkwan/Documents/Overleaf_Projects/학위논문_DK"
git remote add overleaf https://git.overleaf.com/YOUR_PROJECT_ID
git pull overleaf master --allow-unrelated-histories
git push overleaf main:master
```

### 방법 B: Overleaf Free 🆓

**제한**: 수동 동기화, 1명의 협업자만

#### B-1. 수동 업로드/다운로드

1. **GitHub → Overleaf**
   - Overleaf에서 "New Project" → "Upload Project"
   - GitHub에서 ZIP 다운로드 → Overleaf에 업로드

2. **Overleaf → GitHub**
   - Overleaf에서 "Download Source" (ZIP)
   - 로컬에 압축 해제 → Git commit & push

#### B-2. Git 직접 사용 (고급)

```bash
# Overleaf Git URL 가져오기
git remote add overleaf https://git.overleaf.com/YOUR_PROJECT_ID

# Overleaf에서 가져오기
git pull overleaf master

# Overleaf로 보내기
git push overleaf main:master
```

### 방법 C: 완전 로컬 작업

GitHub만 사용하고 Overleaf 없이:

```bash
# VS Code + LaTeX Workshop 확장 설치
# 또는 TeXShop, TeXworks 등 로컬 에디터 사용

# 작업 후
git add .
git commit -m "논문 수정: 3장 추가"
git push origin main
```

---

## 작업 흐름 (Workflow)

### Workflow 1: Overleaf Premium (최적) ⭐

```
[Overleaf에서 작업]
    ↓ (자동 동기화)
[GitHub 저장소]
    ↓ (필요시 pull)
[로컬 작업]
    ↓ (push)
[GitHub 저장소]
    ↓ (자동 동기화)
[Overleaf에서 확인]
```

**일상 작업**:
1. Overleaf에서 편집
2. 저장 (Ctrl+S / Cmd+S)
3. 자동으로 GitHub 동기화 ✅
4. 로컬에서 필요시 `git pull origin main`

### Workflow 2: Overleaf Free (수동)

```
[Overleaf에서 작업]
    ↓ (수동)
[GitHub 수동 업데이트]
    ↓
[로컬 작업]
    ↓
[GitHub push]
    ↓ (수동)
[Overleaf에 반영]
```

**주기적으로**:
- 중요한 변경 후 Overleaf에서 다운로드
- GitHub에 커밋
- 또는 Overleaf Git URL 사용

### Workflow 3: 로컬 중심

```
[로컬 편집기에서 작업]
    ↓ (git commit)
[로컬 Git]
    ↓ (git push)
[GitHub 저장소]
    ↓ (필요시 Overleaf import)
[Overleaf 백업/협업용]
```

---

## Git 작업 명령어 모음

### 기본 작업

```bash
# 현재 상태 확인
git status

# 변경사항 확인
git diff

# 파일 추가 및 커밋
git add main.tex
git commit -m "3장 내용 추가"

# GitHub에 푸시
git push origin main

# GitHub에서 가져오기
git pull origin main
```

### 유용한 커밋 메시지 예시

```bash
git commit -m "초록 작성 완료"
git commit -m "참고문헌 20개 추가"
git commit -m "그림 3.1 수정 및 캡션 개선"
git commit -m "지도교수님 피드백 반영"
git commit -m "오타 수정"
git commit -m "최종본 제출 전 검토 완료"
```

### 브랜치 활용 (선택사항)

```bash
# 실험적인 작업을 위한 브랜치 생성
git checkout -b draft-chapter4

# 작업 후 메인으로 병합
git checkout main
git merge draft-chapter4

# 브랜치 삭제
git branch -d draft-chapter4
```

---

## .gitignore 설명

생성된 `.gitignore` 파일은 다음을 제외합니다:

### LaTeX 빌드 파일
- `.aux`, `.log`, `.out` - 임시 파일
- `.bbl`, `.blg` - 참고문헌 빌드 파일
- `.synctex.gz` - 동기화 파일
- `.fdb_latexmk`, `.fls` - latexmk 빌드 파일

### macOS 시스템 파일
- `.DS_Store` - Finder 설정 파일
- `._*` - 리소스 포크

### 백업 및 임시 파일
- `*~`, `.swp` - 에디터 백업

**포함되는 파일**:
- ✅ `.tex` 소스 파일
- ✅ `.bib` 참고문헌
- ✅ `figures/` 이미지들
- ✅ `.cls`, `.sty` 사용자 정의 스타일
- ✅ `.pdf` 최종 출력 (선택사항)

**PDF 제외하려면**: `.gitignore`에 `*.pdf` 라인 주석 해제

---

## 문제 해결

### 문제 1: Overleaf와 로컬 충돌

**증상**: `git pull` 시 충돌 발생

**해결**:
```bash
# 로컬 변경사항 저장
git stash

# Overleaf에서 가져오기
git pull origin main

# 저장한 변경사항 복원
git stash pop

# 충돌 해결 후
git add .
git commit -m "Overleaf 변경사항과 병합"
git push origin main
```

### 문제 2: 한글 파일명 문제

**증상**: Git이 한글 파일명을 이상하게 표시

**해결**:
```bash
# UTF-8 설정
git config --global core.quotepath false
```

### 문제 3: 빌드 파일이 Git에 추가됨

**증상**: `.aux`, `.log` 파일이 커밋에 포함

**해결**:
```bash
# 이미 추적 중인 파일 제거
git rm --cached *.aux *.log *.fls *.fdb_latexmk *.synctex.gz *.bbl *.blg

# 커밋
git commit -m "빌드 파일 제거"
git push origin main

# .gitignore가 제대로 설정되어 있는지 확인
```

### 문제 4: Overleaf Premium 없이 자동 동기화

**대안**:
1. **GitHub Actions 사용** (고급)
   - 자동 PDF 빌드
   - GitHub → Overleaf 자동 동기화 스크립트

2. **Git hooks 사용**
   - 로컬에서 커밋 시 자동으로 Overleaf에 푸시

3. **주기적 수동 동기화**
   - 하루 1-2회 수동 동기화

### 문제 5: 대용량 파일 문제

**증상**: GitHub가 100MB 이상 파일을 거부

**해결**:
```bash
# Git LFS 사용 (Large File Storage)
git lfs install
git lfs track "*.pdf"
git lfs track "*.png"
git add .gitattributes
git commit -m "Git LFS 설정"
```

---

## 고급 팁

### Tip 1: 자동 빌드 GitHub Actions

`.github/workflows/build.yml` 생성:

```yaml
name: Build LaTeX
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: xu-cheng/latex-action@v2
        with:
          root_file: main.tex
      - uses: actions/upload-artifact@v2
        with:
          name: PDF
          path: main.pdf
```

### Tip 2: Overleaf Git 직접 동기화

양쪽 동기화 스크립트 (`sync.sh`):

```bash
#!/bin/bash
# GitHub에서 가져오기
git pull origin main

# Overleaf로 보내기
git push overleaf main:master

# Overleaf에서 가져오기
git pull overleaf master

# GitHub로 보내기
git push origin main
```

사용: `chmod +x sync.sh && ./sync.sh`

### Tip 3: 태그로 버전 관리

```bash
# 중간 제출본
git tag -a v0.1 -m "초고 제출"
git push origin v0.1

# 최종본
git tag -a v1.0 -m "최종 제출본"
git push origin v1.0

# 태그 목록 보기
git tag -l
```

### Tip 4: 협업자 추가

**GitHub**:
- Settings → Collaborators → Add people

**Overleaf Premium**:
- Share → Invite collaborators (무제한)

**Overleaf Free**:
- 1명만 초대 가능

---

## 추천 작업 환경

### 옵션 1: Overleaf 중심 (간편함) ⭐
- **주 작업**: Overleaf
- **백업**: GitHub (Premium 자동 동기화)
- **장점**: 어디서나 작업, 실시간 협업
- **단점**: 인터넷 필요

### 옵션 2: 로컬 중심 (고급 사용자)
- **주 작업**: VS Code + LaTeX Workshop
- **버전 관리**: Git + GitHub
- **협업/백업**: Overleaf
- **장점**: 오프라인 작업, 강력한 에디터
- **단점**: 환경 설정 필요

### 옵션 3: 하이브리드 (균형)
- **초안 작성**: Overleaf (빠른 편집)
- **정리/최종본**: 로컬 (세밀한 조정)
- **버전 관리**: GitHub (중앙 저장소)
- **장점**: 양쪽 장점 활용
- **단점**: 동기화 관리 필요

---

## 빠른 시작 체크리스트

### ✅ GitHub 저장소 만들기
- [ ] GitHub에서 새 저장소 생성
- [ ] 로컬에서 `git init`
- [ ] 첫 커밋 및 푸시

### ✅ Overleaf 연동
- [ ] Overleaf에서 GitHub import (Premium)
- [ ] 또는 Git URL 추가 (Free)
- [ ] 동기화 테스트

### ✅ 작업 흐름 확립
- [ ] 주 작업 환경 결정
- [ ] 백업 주기 설정
- [ ] 협업자 초대 (필요시)

### ✅ 안전장치
- [ ] `.gitignore` 확인
- [ ] 정기 백업 계획
- [ ] 중요 버전 태그 생성

---

## 추가 리소스

### 공식 문서
- **Overleaf Git**: https://www.overleaf.com/learn/how-to/Using_Git_and_GitHub
- **GitHub 가이드**: https://docs.github.com/en/get-started
- **Git 한글 문서**: https://git-scm.com/book/ko/v2

### 유용한 도구
- **VS Code**: LaTeX Workshop 확장
- **TeXShop** (macOS): 간단한 LaTeX 에디터
- **GitKraken**: GUI Git 클라이언트

### 한국어 LaTeX 리소스
- **KTUG**: http://www.ktug.org/ (한국 TeX 사용자 그룹)
- **ko.TeX**: https://wiki.ktug.org/wiki/wiki.php/koTeXLive

---

## 지원 및 문의

- **Git 문제**: Git 문서 참조 또는 `git --help`
- **Overleaf 문제**: Overleaf 지원센터
- **LaTeX 오류**: KTUG 포럼 또는 Stack Exchange

---

**마지막 업데이트**: 2025-10-14
**작성자**: Yang Deokkwan
**버전**: 1.0
