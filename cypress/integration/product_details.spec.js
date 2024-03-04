describe ('tests product page', () => {
  it('visits homepage', () => {
    cy.visit("http://localhost:3000")
  })

  it('should navigate to product detail page when clicking on a product', () => {
    cy.get('.products a').first().click();
    cy.url().should('include', '/products/');
  })
  
});