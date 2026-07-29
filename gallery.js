const galleryContainer = document.querySelector('[data-gallery]');
const category = document.body.dataset.category;
const categoryProjects = window.galleryData?.[category];

if (galleryContainer) {
  const projects = Array.isArray(categoryProjects) ? categoryProjects : categoryProjects ? [categoryProjects] : [];

  if (projects.length === 0) {
    galleryContainer.innerHTML = '<p class="empty-gallery">Próximamente agregaremos nuevos proyectos a esta categoría.</p>';
  } else {
    galleryContainer.innerHTML = projects.map((project) => `
      <a class="gallery-card" href="${project.src}" target="_blank" rel="noopener">
        <img src="${project.src}" alt="${project.title}" loading="lazy" />
        <span class="project-label"><strong>${project.title}</strong><small>${project.description}</small></span>
      </a>
    `).join('');
  }
}
