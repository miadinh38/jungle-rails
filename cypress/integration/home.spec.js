describe ('tests hompage', () => {
  it('visits homepage', () => {
    cy.visit("http://localhost:3000")
  })
  

  it("There are 2 products on the page", () => {
    cy.get('.products article').should("have.length", 2);
  })
});
