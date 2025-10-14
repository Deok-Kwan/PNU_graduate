# 학위논문 (Thesis)

한국어 학위논문 LaTeX 프로젝트입니다.

## 프로젝트 구조

```
.
├── main.tex              # 메인 LaTeX 파일
├── Ref.bib              # 참고문헌 데이터베이스
├── list_of_figures.tex  # 그림 목록
├── list_of_tables.tex   # 표 목록
└── figures/             # 그림 파일 디렉토리
```

## 컴파일 방법

### Overleaf (권장)
1. Overleaf에서 프로젝트 열기
2. 자동으로 컴파일됨 (또는 Ctrl+S / Cmd+S로 재컴파일)

### 로컬 환경
```bash
# pdflatex 사용
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex

# 또는 latexmk 사용 (권장)
latexmk -pdf main.tex
```

## GitHub-Overleaf 연동

이 프로젝트는 GitHub와 Overleaf가 연동되어 있습니다.

### 작업 흐름

1. **Overleaf에서 작업**: 온라인에서 직접 편집
2. **자동 동기화**: Overleaf Premium의 경우 GitHub와 자동 동기화
3. **로컬 작업**: 필요시 로컬에서 pull → 작업 → push

### 주의사항

- 빌드 파일(`.aux`, `.log` 등)은 Git에 포함되지 않습니다
- `.gitignore`가 설정되어 있습니다
- 이미지 파일은 Git에 포함됩니다
- PDF 출력 파일은 현재 Git에 포함됩니다 (필요시 제외 가능)

## 요구사항

- XeLaTeX 또는 pdfLaTeX
- kotex 패키지 (한글 지원)
- 기타 LaTeX 패키지들은 main.tex 참조

## 기여

논문 작성자: Yang Deokkwan

## 라이선스

학위논문으로 저작권은 작성자에게 있습니다.
